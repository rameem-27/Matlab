%Error perfomance of QPSK
clear;
clc;
N = 1000000;
EbNodb = -4:2:10;
data = randn(1, N) >= 0;
oddData = data(1:2:end);
evenData = data(2:2:end);
qpskModulated = sqrt(1/2) * (1i * (2 * oddData - 1) + (2 * evenData - 1));
M = 4;
Rm = log2(M);
Rc = 1;
BER = zeros(1, length(EbNodb));
index = 1;
for i = 1:length(EbNodb)
    EbNo = 10^(EbNodb(i)/10);
    noiseSigma = sqrt(1 / (2 * Rm * Rc * EbNo));
    noise = noiseSigma * (randn(1, length(qpskModulated)) + 1i * randn(1, length(qpskModulated)));
    received = qpskModulated + noise;
    detected_real = real(received) >= 0;
    detected_imag = imag(received) >= 0;
    estimatedBits = reshape([detected_imag; detected_real], 1, []);
    BER(index) = sum(xor(data, estimatedBits)) / length(data);
    index = index + 1;
end
plotHandle = plot(EbNodb, log10(BER), 'r--');
set(plotHandle, 'LineWidth', 1.5);
title('SNR per bit (Eb/No) Vs BER curve for QPSK modulation scheme');
xlabel('SNR per bit (Eb/No) in dB');
ylabel('Bit Error Rate (BER) in dB');
grid on;
hold on;
theoreticalBER = 0.5 * erfc(sqrt(10.^(EbNodb/10)));
plotHandle = plot(EbNodb, log10(theoreticalBER), 'b*');
set(plotHandle, 'LineWidth', 1.5);
legend('Simulated', 'Theoretical QPSK', 'Theoretical-QPSK');
grid on;


