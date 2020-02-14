close all

%% Load files
f0=0;
f1=20;
amp=3;
dur=20000;
% DC=-100;

current=cd;
cd('/Users/scottrich/OneDrive - UHN/3) NEURON stuff/Human Cell');

str1=sprintf('ZapData_time_%d_%d_%d_%d.csv', f0, f1, amp, dur);
str2=sprintf('ZapData_voltage_%d_%d_%d_%d.csv', f0, f1, amp, dur);
str3=sprintf('ZapData_zapcurrent_%d_%d_%d_%d.csv', f0, f1, amp, dur);
% str1=sprintf('ZapData_time_%d_%d_%d_%d_%d.csv', f0, f1, amp, dur, DC);
% str2=sprintf('ZapData_voltage_%d_%d_%d_%d_%d.csv', f0, f1, amp, dur, DC);
% str3=sprintf('ZapData_zapcurrent_%d_%d_%d_%d_%d.csv', f0, f1, amp, dur, DC);

time=csvread(str1);
voltage=csvread(str2);
zapcurrent=csvread(str3);

cd(current)

%% Take FFT
if mod(length(time),2)==1
    voltage=voltage(1:end-1);
    zapcurrent=zapcurrent(1:end-1);
    time=time(1:end-1);
end

[voltage_re, time_re]=resample(voltage, time);
zapcurrent_re=resample(zapcurrent, time);
L=length(time_re);

T=time_re(2); % Sampling Period in ms
Fs=1/(T/1000); % Sampling Frequency in Hz
f = Fs*(0:(L/2))/L;

voltage_fft=fft(voltage_re-mean(voltage_re));
P2 = abs(voltage_fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
voltage_powerspectrum=P1;

zapcurrent_fft=fft(zapcurrent_re);
P2 = abs(zapcurrent_fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
zapcurrent_powerspectrum=P1;

%% Final Plotting
Z=voltage_powerspectrum./zapcurrent_powerspectrum;

figure('units','normalized','position',[0 0 1 1])
plot(f,Z);
axis([f0 f1 0 max(Z(find(f<f1)))+5])
set(gca, 'FontSize', 20);
xlabel('Frequency (Hz)', 'FontSize', 26)
ylabel('Impedance', 'FontSize', 26)
title('Voltage Power Spectrum over ZAP Power Spectrum', 'FontSize', 30);

str1=sprintf('ImpedancePlot_%d_%d_%d_%d.png', f0, f1, amp, dur);
%     saveas(gcf, str1)
set(gcf,'PaperPositionMode','auto')
print(str1, '-dpng', '-r0');
% str1=sprintf('ImpedancePlotDC_%d_%d_%d_%d_%d.png', f0, f1, amp, dur, DC);
% %     saveas(gcf, str1)
% set(gcf,'PaperPositionMode','auto')
% print(str1, '-dpng', '-r0');


