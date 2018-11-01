onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider system_signal
add wave -noupdate -radix hexadecimal /NMR_PULSE_PROGRAM_tb/uut/State
add wave -noupdate /NMR_PULSE_PROGRAM_tb/CLK
add wave -noupdate /NMR_PULSE_PROGRAM_tb/RESET
add wave -noupdate /NMR_PULSE_PROGRAM_tb/START
add wave -noupdate /NMR_PULSE_PROGRAM_tb/FSMSTAT
add wave -noupdate /NMR_PULSE_PROGRAM_tb/ACQ_EN
add wave -noupdate -divider rollover
add wave -noupdate -radix unsigned {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[31]}
add wave -noupdate -radix unsigned {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[31]}
add wave -noupdate -radix unsigned {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[31]}
add wave -noupdate -radix unsigned {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[31]}
add wave -noupdate -radix unsigned {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[31]}
add wave -noupdate -divider counters
add wave -noupdate -radix hexadecimal -childformat {{{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[31]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[30]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[29]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[28]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[27]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[26]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[25]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[24]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[23]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[22]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[21]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[20]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[19]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[18]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[17]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[16]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[15]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[14]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[13]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[12]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[11]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[10]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[9]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[8]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[7]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[6]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[5]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[4]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[3]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[2]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[1]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[0]} -radix unsigned}} -subitemconfig {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[31]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[30]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[29]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[28]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[27]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[26]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[25]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[24]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[23]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[22]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[21]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[20]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[19]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[18]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[17]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[16]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[15]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[14]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[13]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[12]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[11]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[10]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[9]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[8]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[7]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[6]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[5]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[4]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[3]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[2]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[1]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT[0]} {-height 15 -radix unsigned}} /NMR_PULSE_PROGRAM_tb/uut/DELAY_NO_ACQ_CNT
add wave -noupdate -radix hexadecimal -childformat {{{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[31]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[30]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[29]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[28]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[27]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[26]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[25]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[24]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[23]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[22]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[21]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[20]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[19]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[18]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[17]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[16]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[15]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[14]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[13]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[12]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[11]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[10]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[9]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[8]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[7]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[6]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[5]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[4]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[3]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[2]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[1]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[0]} -radix unsigned}} -subitemconfig {{/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[31]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[30]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[29]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[28]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[27]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[26]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[25]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[24]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[23]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[22]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[21]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[20]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[19]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[18]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[17]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[16]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[15]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[14]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[13]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[12]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[11]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[10]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[9]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[8]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[7]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[6]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[5]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[4]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[3]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[2]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[1]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT[0]} {-height 15 -radix unsigned}} /NMR_PULSE_PROGRAM_tb/uut/DELAY_WITH_ACQ_CNT
add wave -noupdate -radix hexadecimal -childformat {{{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[31]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[30]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[29]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[28]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[27]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[26]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[25]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[24]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[23]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[22]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[21]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[20]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[19]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[18]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[17]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[16]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[15]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[14]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[13]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[12]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[11]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[10]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[9]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[8]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[7]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[6]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[5]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[4]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[3]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[2]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[1]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[0]} -radix unsigned}} -subitemconfig {{/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[31]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[30]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[29]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[28]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[27]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[26]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[25]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[24]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[23]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[22]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[21]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[20]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[19]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[18]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[17]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[16]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[15]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[14]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[13]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[12]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[11]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[10]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[9]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[8]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[7]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[6]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[5]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[4]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[3]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[2]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[1]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT[0]} {-height 15 -radix unsigned}} /NMR_PULSE_PROGRAM_tb/uut/ECHO_PER_SCAN_CNT
add wave -noupdate -radix hexadecimal -childformat {{{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[31]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[30]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[29]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[28]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[27]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[26]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[25]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[24]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[23]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[22]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[21]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[20]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[19]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[18]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[17]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[16]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[15]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[14]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[13]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[12]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[11]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[10]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[9]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[8]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[7]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[6]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[5]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[4]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[3]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[2]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[1]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[0]} -radix unsigned}} -subitemconfig {{/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[31]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[30]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[29]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[28]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[27]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[26]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[25]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[24]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[23]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[22]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[21]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[20]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[19]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[18]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[17]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[16]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[15]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[14]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[13]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[12]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[11]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[10]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[9]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[8]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[7]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[6]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[5]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[4]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[3]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[2]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[1]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT[0]} {-height 15 -radix unsigned}} /NMR_PULSE_PROGRAM_tb/uut/PULSE90_CNT
add wave -noupdate -radix hexadecimal -childformat {{{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[31]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[30]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[29]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[28]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[27]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[26]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[25]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[24]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[23]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[22]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[21]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[20]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[19]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[18]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[17]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[16]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[15]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[14]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[13]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[12]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[11]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[10]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[9]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[8]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[7]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[6]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[5]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[4]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[3]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[2]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[1]} -radix unsigned} {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[0]} -radix unsigned}} -subitemconfig {{/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[31]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[30]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[29]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[28]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[27]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[26]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[25]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[24]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[23]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[22]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[21]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[20]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[19]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[18]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[17]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[16]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[15]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[14]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[13]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[12]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[11]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[10]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[9]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[8]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[7]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[6]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[5]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[4]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[3]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[2]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[1]} {-height 15 -radix unsigned} {/NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT[0]} {-height 15 -radix unsigned}} /NMR_PULSE_PROGRAM_tb/uut/PULSE180_CNT
add wave -noupdate -divider parameters
add wave -noupdate -radix unsigned /NMR_PULSE_PROGRAM_tb/PULSE90
add wave -noupdate -radix unsigned /NMR_PULSE_PROGRAM_tb/DELAY_NO_ACQ
add wave -noupdate -radix unsigned /NMR_PULSE_PROGRAM_tb/PULSE180
add wave -noupdate -radix unsigned /NMR_PULSE_PROGRAM_tb/DELAY_WITH_ACQ
add wave -noupdate -radix unsigned /NMR_PULSE_PROGRAM_tb/ECHO_PER_SCAN
add wave -noupdate -divider output_clocks
add wave -noupdate /NMR_PULSE_PROGRAM_tb/ADC_CLK
add wave -noupdate -divider tx_output
add wave -noupdate /NMR_PULSE_PROGRAM_tb/uut/OUT_EN
add wave -noupdate /NMR_PULSE_PROGRAM_tb/uut/PHASE
add wave -noupdate /NMR_PULSE_PROGRAM_tb/PHASE_CYC
add wave -noupdate /NMR_PULSE_PROGRAM_tb/uut/TX_CLK_X
add wave -noupdate /NMR_PULSE_PROGRAM_tb/uut/TX_CLK_Y
add wave -noupdate -color Yellow /NMR_PULSE_PROGRAM_tb/TX_OUT_P
add wave -noupdate -color Yellow /NMR_PULSE_PROGRAM_tb/TX_OUT_N
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42256098 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 290
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 10
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {105 us}
