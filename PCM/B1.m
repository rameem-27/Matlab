%Perfomance of wave coding using PCM
clc;
clear all;
clear all;
fm=5;
A=5;
fs=50;
n=4;
t=0:1/(100*fm):1;
x=A*cos(2*pi*fm*t);
ts=0:1/fs:1;
xs=A*cos(2*pi*fm*ts);
x1=xs+A;
x1=x1/(2*A);
L=(-1+2^n);
x1=L*x1;
xq=round(x1);
y=[];
for i=1:length(xq)
    d=dec2bin(xq(i),n);
    y=[y double(d)-48];
end;
 figure(1)
 plot(t,x,'linewidth',2)
 title('Sampling')
 ylabel('Amplitude')
 xlabel('Time t(in sec)')
 hold on
 stem(ts,xs,'r','linewidth',2)
 hold off
 legend('Original Signal','Sampling Signal');
 
 figure(2)
 stem(ts,x1,'linewidth',2)
 title('Quantization')
 ylabel('Levels L')
 hold on
 stem(ts,xq,'r','linewidth',2)
 plot(ts,xq,'--r')
 plot(t,(x+A)*L/(2*A),'--b')
 grid on
 hold off
 legend('Sampled Signal','Quantized Signal')
 
 figure(3)
 stairs([y y(length(y))],'linewidth',2)
 title('encoding')
 ylabel('bits')
 xlabel([0 length(y)-1 2])
 grid on

    
