%Error perfomance of BPSK
clc;
clear all;
close all;
N = 10000;
msg = rand(1, N) > 0.5;
EbNodb = 1:1:7;
R = 1;
err = zeros(1, 7);
BERtheory = zeros(1, 7);
for i = 1:length(EbNodb)
    EbNo = 10^(EbNodb(i)/10);
    sigma = sqrt(1/(2*R*EbNo));
    s = 2*msg - 1;
    r = s + sigma*randn(1, N);
    msgcap = (r > 0);
    err(i) = sum(msg ~= msgcap) / N;
    BERtheory(i) = 0.5 * erfc(sqrt(EbNo));
end
figure;
% Practical BER subplot
subplot(2, 1, 1);
semilogy(EbNodb, err, '-.*g', 'LineWidth', 2);
grid on;
xlabel('Eb/No (dB)');
ylabel('BER');
title('Practical BER');
% Theoretical BER subplot
subplot(2, 1, 2);
semilogy(EbNodb, BERtheory, 'r');
grid on;
xlabel('Eb/No (dB)');
ylabel('BER');
title('Theoretical BER');
% Adjusting the position of the subplots
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [1 1 0 0; 0 0 1 1]);
sgtitle('BPSK Performance');




