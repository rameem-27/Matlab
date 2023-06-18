%Pulse shaping and matched filtering
clc;
clear all;
close all; 
overSampling_Factor=8;
Input_bit = [1];
Input_bit_os=upsample(Input_bit,overSampling_Factor);
alpha=0.4;
pt = srrc(overSampling_Factor,alpha);
output_of_srrc_filter = conv(Input_bit_os,pt);
figure;
stem(output_of_srrc_filter);
title('Response of SRRC Filter at Tx side')
xlabel('Samples')
ylabel('Amplitude') 
output_of_srrc_filter=awgn(output_of_srrc_filter,100); 
y = conv(output_of_srrc_filter,pt);
figure;
stem(y);
title('Matched filter (SRRC) response at Rx side');
xlabel('Samples');
ylabel('Amplitude');
midSample=length(-4:1/overSampling_Factor:4);
y_truncated=y(midSample-1:end);
y_down = downsample(y_truncated,overSampling_Factor,1); 
figure;
stem(y_down);
title('Down sampled output (ADC conversion and Sampling)');
xlabel('Samples');
ylabel('Amplitude');