%%% Driver for processing of T1T2 experiments on the Kea System.
% The inversion is done with the FLI2d function in Yi-Qiao's inversion
% package.  The binary data is loaded into MATLAB with the LoadProspaData
% function provided by Magritek.
% Written by Ben Chapman.  Last revised 5/25/11.
% Modifed by Soumyajit Mandal
% Converted into a function, 5/31/11
% Modified to handle both Kea and Bruker data, (echoTime, echoPnts only
% need to be supplied for Bruker data), 2/22/12
% Modified to use correct definition of matched filter, 2/27/12
% Modified to work with Kea v2.20 T1-T2 data (long-time data already
% subtracted) and to include diffusion during the CPMG if the diffusion
% constant is known

function KeaT1T2analysis_new3(path_curr,expnum,grad_file,D)
%% define parameters
datadirectory = [path_curr filesep num2str(expnum)]; %directory of kea data
NumT1Bins = 100;
NumT2Bins = 100;
T2minp = -3; %These are decades for a log-spaced vector, e.g. T2min = 10^T2minp (units are seconds)
T2maxp = 2;
T1minp = -3;
T1maxp = 2;

gamma = 2*pi*42.5775e6; % gyromagnetic ratio
% Load gradient file
tmp=load([path_curr filesep grad_file '.mat']);
g = tmp.g; fg = tmp.fg; % static gradient, T/m and normalized distribution f(g)
numg = length(g);

eta = 1.37; % effective diffusion decay rate during CPMG

Dvect = ones(1,NumT2Bins)*D;

%% get the experimental data

% read kea data
[RawData,TE1times,ExpTime,AcqTime] = LoadKeaT1T2data_new2(path_curr,expnum); %loads the raw data
%RawData = [ComplexPts,NumEchoes,NumTE1times]; % 3D data
TE1times = 1e-3*TE1times; %convert to s
AcqTimeVec = 1e-3*AcqTime; %in s
ExptTimeVec = 1e-6*ExpTime; %in s

NumEchoes = length(ExptTimeVec); %get number of echoes
ComplexPts = length(AcqTimeVec); %get number of acquired pts per echo
NumTE1times = length(TE1times); %determine number of delays
NumDelayTimes = NumTE1times;  %determine number of delay times (tau values) used for the inversion

TE2 = ExptTimeVec(2)-ExptTimeVec(1); %get echo time
%ExptTimeVec=ExptTimeVec-TE2; % First echo occurs at t = TE2

%% get average echo shape

%fully polarized data has already been subtracted by the Kea
CorrectedData = RawData;

startecho = 3; endecho = min(50,NumEchoes); %we use echoes 3-50 to avoid adding extra noise to the data
%weight echoes from each delay time
DelayTimeWeights = reshape(sqrt(sum(sum(real(CorrectedData(:,startecho:endecho,:)),2).^2 +...
    sum(imag(CorrectedData(:,startecho:endecho,:)),2).^2,1)),NumDelayTimes,1);

AvgEchoShape = reshape(sum(CorrectedData(:,startecho:endecho,:),2),ComplexPts,NumDelayTimes)*...
    DelayTimeWeights;
theta=atan2(sum(imag(AvgEchoShape)),sum(real(AvgEchoShape)));

% Rotate signal into real channel
AvgEchoShape=AvgEchoShape*exp(-1i*theta);
CorrectedData=CorrectedData*exp(-1i*theta);

if ComplexPts>1
    figure;
    plot(AcqTimeVec*1e6,real(AvgEchoShape),'b-'); hold on;
    plot(AcqTimeVec*1e6,imag(AvgEchoShape),'r-');
    plot(AcqTimeVec*1e6,abs(AvgEchoShape),'k-');
    xlabel('Acquisition Time Axis [{\mu}s]');
    ylabel('Average echo shape [a.u.]');
    
    p1=polyfit(AcqTimeVec*1e6,real(AvgEchoShape),2);
    p2=polyfit(AcqTimeVec*1e6,imag(AvgEchoShape),3);
    AvgEchoShape=polyval(p1,AcqTimeVec*1e6)+1i*polyval(p2,AcqTimeVec*1e6);
    
    plot(AcqTimeVec*1e6,real(AvgEchoShape),'b--');
    plot(AcqTimeVec*1e6,imag(AvgEchoShape),'r--');
    plot(AcqTimeVec*1e6,abs(AvgEchoShape),'k--');
end

%% extract amplitude for each echo and normalize

IntegratedData = zeros(NumEchoes,NumDelayTimes);
mf=conj(AvgEchoShape); % Matched filter window
%mf=ones(ComplexPts,1); % Rectangular window
for ii = 1:NumDelayTimes
    for k=1:NumEchoes
        % Filter each echo with the matched filter
        IntegratedData(k,ii)=sum(CorrectedData(:,k,ii).*mf);
    end
end

%StdNoise=mean(std(imag(IntegratedData),0,2));
%MaxSig = max(max(real(IntegratedData)))-1.5*StdNoise;
MaxSig = max(max(real(IntegratedData)));
NormIntegratedData = IntegratedData/MaxSig; %normalize

%to compare with avg echo shape, for quality control
Shapes  = reshape(sum(CorrectedData(:,startecho:endecho,:),2),ComplexPts,NumDelayTimes)...
    .*sum(AvgEchoShape)';

%% estimate noise
% std deviation of out of phase channel.
stdout = mean(std(imag(NormIntegratedData),0,2));

%% check raw echoes
if ComplexPts>1
    plotinds = round(linspace(1,NumDelayTimes,6));
    figure;
    for ii = 1:6
        subplot(3,2,ii); pcolor(ExptTimeVec,AcqTimeVec*1e6,real(CorrectedData(:,:,plotinds(ii)))); shading flat;
        set(gca,'TickDir','out');
        if ii > 4
            xlabel('Expt Time Axis [s]');
        end
        if mod(ii,2)
            ylabel('Acquisition Time Axis [{\mu}s]');
        end
    end
    saveas(gcf,[datadirectory '\RawData']);
    close(gcf);
end
%% check echo shapes
if ComplexPts>1
    SuperEchoes = squeeze(sum(repmat(max(real(CorrectedData)),ComplexPts,1).*CorrectedData,2));
    figure; plot(AcqTimeVec*1e6,real(SuperEchoes(:,plotinds))); hold on;
    plot(AcqTimeVec*1e6,imag(SuperEchoes(:,plotinds)),'--'); hold on;
    %plot(AcqTimeVec*1e6,-real(sum(FPdata.*repmat(max(real(FPdata)),ComplexPts,1),2)),'k')
    xlabel('Acquisition Time Axis [{\mu}s]'); ylabel('Signal from Summed Echoes [a.u.]');
    legend(num2str(TE1times(plotinds)));
    saveas(gcf,[datadirectory '\SuperEchoes']);
    
    maxsig = max(max(real(SuperEchoes)));
    ScaledSuperEchoes = repmat(maxsig./max(real(SuperEchoes)),ComplexPts,1)...
        .*real(SuperEchoes);
    
    figure; plot(AcqTimeVec*1e6,ScaledSuperEchoes(:,plotinds));
    hold on; %plot avg. echo shape
    plot(AcqTimeVec*1e6,maxsig/max(real(AvgEchoShape))*real(AvgEchoShape),'b--');
    %plot(AcqTimeVec*1e6,maxsig/max(real(AvgEchoShape))*imag(AvgEchoShape),'r--');
    xlabel('Acquisition Time Axis [{\mu}s]'); ylabel('Signal from Summed Echoes [a.u.]');
    legend(num2str(TE1times(plotinds)));
    saveas(gcf,[datadirectory '\ScaledSuperEchoes']);
end
%% display raw data as decay curves
data2d = real(NormIntegratedData);
T1spc = 1; tauspc = 1;
scfactors = repmat(1./mean(data2d(1:endecho,:)),NumEchoes,1).*data2d;
figure; plot(ExptTimeVec(1:tauspc:end),data2d(1:tauspc:end,1:T1spc:end));
xlabel('Time [s]'); ylabel('magnetization [a.u.]');
title('Normalized Decay Curves for Different TE1, in {\mu}s');
legend(num2str(round(1e6*TE1times(1:T1spc:end))));
xlim([0 ExptTimeVec(end)]); ylim([0 1]);
saveas(gcf,[datadirectory '\DecayCurves']);

figure; semilogy(ExptTimeVec(1:tauspc:end),data2d(1:tauspc:end,1:T1spc:end));
xlabel('Time [s]'); ylabel('magnetization [a.u.]');
title('Normalized Decay Curves for Different TE1, in {\mu}s');
legend(num2str(round(1e6*TE1times(1:T1spc:end))));
xlim([0 ExptTimeVec(end)]); ylim([0 1]);
saveas(gcf,[datadirectory '\LogDecayCurves']);

% figure; plot(ExptTimeVec(1:tauspc:end),scfactors(1:tauspc:(end),1:T1spc:end));
% xlabel('Time [s]'); ylabel('Magnetization [a.u. where M{_{0}} = 1]');
% title('Normalized Decay Curves for Different TE1, in {\mu}s');
% legend(num2str(round(1e6*TE1times(1:T1spc:end))));
% xlim([0 ExptTimeVec(end)]); ylim([0 1]);
% saveas(gcf,[datadirectory '\NormDecayCurves']);

%% 1-d inversion of kernel 1 (T1)
T1 = logspace(T1minp,T1maxp,NumT1Bins);
K1=exp(- TE1times(1:NumDelayTimes) * (1./T1));
[U1, S1, V1] = svds(K1, 14);

% data1=real(NormIntegratedData(8,:));
% [FofT1,alpha_T1,T1fit] = FLI1d(data1,K1,-2,U1,S1,V1);
%check inversion
% figure; semilogx(T1,FofT1)
%% 1-d inversion of kernel 2 (T_2)
T2 = logspace(T2minp,T2maxp,NumT2Bins);
K2 = exp(- ExptTimeVec * (1./T2));
[U2, S2, V2] = svds(K2, 14);

% data2 = real(NormIntegratedData(:,1)).';
% [FofT2,alpha_T2,T2fit] = FLI1d(data2,K2,-2,U2,S2,V2);
% %check to see if inversion makes sense...
% figure; subplot(211); plot(ExptTimeVec,data2,'o',ExptTimeVec,T2fit,'r'); subplot(212); semilogx(T2,FofT2);
%% 2d inversion
AlphaLength = 6;
theAlphalist = logspace(2,-2,AlphaLength); %generate list of alphas
FEstlist = {}; %define cell array FEstlist

% Modified relaxation kernel - takes diffusion during CPMG into account
K2=zeros(NumEchoes,NumT2Bins);
for j=1:numg
    K2=K2+fg(j)*exp(- ExptTimeVec * (1./T2)).*exp(-eta*(gamma*g(j)*TE2).^2.*ExptTimeVec * Dvect/12);
end

for ii = 1:length(theAlphalist) %loop through alphas and do inversion for each value
    [FEst,alpha2,Fit] = FLI2d(data2d,K1,K2,theAlphalist(ii),U1,S1,V1,U2,S2,V2);
    FEstlist{ii}.f = FEst;
    FEstlist{ii}.alpha = alpha2.alpha;
    FEstlist{ii}.chi = alpha2.chi;
    FEstlist{ii}.Fit = Fit; %combined into two loops
    theChilist(ii) = FEstlist{ii}.chi;
    theChilist2 (ii) = sqrt(mean(mean((data2d - FEstlist{ii}.Fit) .^ 2)));
    
end

theIndex = 3; %choose alpha index to plot T1 and T2 fits
FEst = FEstlist{theIndex}.f;
Fit = FEstlist{theIndex}.Fit;

%% save routine
thefile= [datadirectory '\T1T2analysis.mat'];
if exist(thefile,'file') == 0
    save(thefile)
else
    thefile1 = input('please input a new file name (return to overwrite):');
    if isempty(thefile1)
        save(thefile)
    else
        save (thefile1)
    end
end

% plotting routines
%% compare T2 fits
plotinds = 1:3;
figure;
semilogx(ExptTimeVec,mean(real(NormIntegratedData(:,plotinds)),2),'k'); hold on;
semilogx(ExptTimeVec,mean(FEstlist{theIndex}.Fit(:,plotinds),2),'r');
ylabel('signal [a.u.]'); xlim([ExptTimeVec(1) ExptTimeVec(end)]);
ylim([0 1]); title(['average T_2 fit for delay times ' num2str(plotinds(1)) ' through ' num2str(plotinds(end))]);
xlabel('time [s]');

saveas(gcf,[datadirectory '\T2fits']);
%% T1 fits
plotindsE = 1:(min(10,NumEchoes));
figure;
semilogx(TE1times(1:NumDelayTimes),mean(NormIntegratedData(plotindsE,:)),'ko'); hold on;
semilogx(TE1times(1:NumDelayTimes),mean(FEstlist{theIndex}.Fit(plotindsE,:)),'r');
ylabel('signal [a.u.]');
title(['average T_1 fit for echoes ' num2str(plotindsE(1)) ' through ' num2str(plotindsE(end))]); %ylim([0 1]);
xlabel('delay time [s]');
saveas(gcf,[datadirectory '\T1fits']);


%% plot the kernels
NumK1Cols = 8;
NumK2Cols = 10;
figure;
subplot(211); pcolor(T1,TE1times(1:NumDelayTimes),K1); xlabel('T_1 [s]');
ylabel('delay time [s]'); axis square;
colorbar; title('Kernel 1'); shading flat; set(gca,'clim',[0 1],'xscale','log');
subplot(212); pcolor(T2,ExptTimeVec,K2); xlabel('T{_2} [s]'); ylabel('time [s]');
title('Kernel 2'); shading flat; set(gca,'clim',[0 1],'xscale','log'); colorbar; axis square;
saveas(gcf,[datadirectory '\Kernels']);

%% compare 2d data to fit on grid

figure;
subplot(221); pcolor(ExptTimeVec,TE1times(1:NumDelayTimes),data2d'); shading flat;
set(gca,'yscale','log','tickdir','out','clim',[0 1]);
colorbar; ylabel('delay time [s]');  title('2-d data'); xlabel('time [s]'); axis square;
subplot(222); pcolor(ExptTimeVec,TE1times(1:NumDelayTimes),Fit'); shading flat;
set(gca,'yscale','log','tickdir','out','clim',[0 1]);
colorbar;  title('2-d fit'); xlabel('time [s]'); axis square;
ylabel('delay time [s]');

subplot(223); pcolor(ExptTimeVec,TE1times(1:NumDelayTimes),data2d'-Fit'); shading flat;
set(gca,'yscale','log','tickdir','out'); title('data-fit'); axis square;
colorbar; ylabel('delay time [s]'); xlabel('time [s]');

saveas(gcf,[datadirectory '\2dDataAndFit']);
close(gcf)

%% plot T1T2 maps for each alpha value

for ii = 1:length(theAlphalist)
    fnf = sum(sum(FEstlist{ii}.f));
    fnorm = 1/fnf*FEstlist{ii}.f';
    T2lm =  exp(sum(log(T2).*sum(fnorm,1)));
    T1lm = exp(sum(log(T1').*sum(fnorm,2)));
    
    figure('OuterPosition',[100,100,1200,1000])
    subplot(3,3,[2 3 5 6])
    contour(T2,T1,FEstlist{ii}.f.',8); hold on;
    set(gca,'xscale','log','yscale','log');
    loglog([T2(1) T2(end)],[T2(1) T2(end)],'k--');
    xlabel('T_2'); ylabel('T_1');
    
    subplot(3,3,[8 9]);
    semilogx(T2,sum(FEstlist{ii}.f.',1));
    xlim([10^(T2minp) 10^(T2maxp)])
    xlabel('T_2');
    
    subplot(3,3,[1 4]);
    semilogy(sum(FEstlist{ii}.f.',2),T1);
    ylim([10^(T1minp) 10^(T1maxp)])
    ylabel('T_1');
    
    subplot(3,3,7);
    plot(eye(4));
    cla;
    axis off;
    text(0,1,['\alpha = ' num2str(FEstlist{ii}.alpha)]);
    text(0,.8,['T_{1lm} = ' num2str(T1lm*1e3,3) ' ms']);
    text(0,.6,['T_{2lm} = ' num2str(T2lm*1e3,3) ' ms']);
    text(0,.4,['SNR \approx ' num2str(1/stdout,3)]);
    text(0,.2,['\chi = ' num2str(FEstlist{ii}.chi,4)]);
    saveas(gcf,[datadirectory '\T1T2maps_alphaind' num2str(ii)]);
end


%% this cell is used to generate the TE1 list, and is not used in the processing.  (list is saved as TE1times.txt)
% MinDelay = 100*1e-3;%ms
% MaxDelay = 2000*1e-3; %ms
% NumDelayTimes = 15;
% NumLongDelays = ceil(NumDelayTimes/6);
% TE1list = round([1e3*logspace(log10(MinDelay),log10(MaxDelay),NumDelayTimes) 5*MaxDelay*1e3*ones(1,NumLongDelays)]'); %paste this array into TE1times.txt (times are in us)
% TE1filename = 'TE1Times.txt';
%
%
% cd('D:\DOCUMENTS\AsphalteneProject\RawData');
% fid = fopen(TE1filename, 'w');
% fprintf(fid,'%u\r\n',TE1list);
% fclose(fid);
%
% cd(datadirectory)
% % fid = fopen(TE1filename, 'w');
% % fprintf(fid,'%u\r\n',TE1list);
% % fclose(fid);