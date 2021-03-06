function [RawData,currValues,lDelta,bTau,ExpTime,AcqTime] = LoadKeaPGSEB_T2data_new2(path_curr,exptnum)

% Read parameters
acqTime=read_kea_acqu(path_curr,exptnum,'acqTime'); % ms
nrPnts=1; % Single complex point stored per echo
nrEchoes=read_kea_acqu(path_curr,exptnum,'nrEchoes');
echoTime=read_kea_acqu(path_curr,exptnum,'echoTime'); % us
b1Freq=read_kea_acqu(path_curr,exptnum,'b1Freq') % MHz
Sample=read_kea_acqu_string(path_curr,exptnum,'Sample') % sample name

lDelta=read_kea_acqu(path_curr,exptnum,'lDelta'); % little delta, us
bTau=read_kea_acqu(path_curr,exptnum,'bTau'); % big Tau, us

% Read current amplitudes (all in A)

cAmp=read_kea_acqu(path_curr,exptnum,'cAmp'); % max current, A
stepSize=read_kea_acqu(path_curr,exptnum,'stepSize'); % current steps, A
numGrad=cAmp/stepSize+1;

currValues=linspace(0,cAmp,numGrad)'; % Linear

AcqTime=acqTime*linspace(0,1,nrPnts)';
ExpTime=echoTime*linspace(0,nrEchoes-1,nrEchoes)';

filname=[path_curr filesep num2str(exptnum) filesep 'data2.csv'];
tmp=csvread(filname);

RawData=zeros(nrPnts,nrEchoes,numGrad);
% Rearrange data to get complex points and split them into echoes
for j=1:numGrad
    tmp_c=tmp(j,1:2:2*nrPnts*nrEchoes-1)'+1i*tmp(j,2:2:2*nrPnts*nrEchoes)'; % Unshuffle
    for i=1:nrEchoes % Split into echoes
        RawData(:,i,j)=tmp_c((i-1)*nrPnts+1:i*nrPnts);
    end
end