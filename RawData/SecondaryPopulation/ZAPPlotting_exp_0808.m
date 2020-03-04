close all
clear
clc

%% Load files
load('ZAP_exp_2.mat')

time=0.1:.1:20645;
f0=0;
f1=20;

for i=1:8
    current=A(:,4,i);
    current=current*.001; %Convert to nA
    voltage=A(:,3,i);
    
    current_FFT=current((322.6/.1):(20000/.1));
    voltage_FFT=voltage((322.6/.1):(20000/.1));
    time_FFT=time((322.6/.1):(20000/.1));

%% Take FFT
if mod(length(time),2)==1
    voltage_FFT=voltage_FFT(1:end-1);
    current_FFT=current_FFT(1:end-1);
    time_FFT=time_FFT(1:end-1);
end

% [voltage_re, time_re]=resample(voltage, time);
% zapcurrent_re=resample(zapcurrent, time);
% L=length(time_re);

L=length(time_FFT);
T=.1; % Sampling Period in ms
Fs=1/(T/1000); % Sampling Frequency in Hz
f = Fs*(0:(L/2))/L;

voltage_fft=fft(voltage_FFT-mean(voltage_FFT));
P2 = abs(voltage_fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
voltage_powerspectrum=P1;

zapcurrent_fft=fft(current_FFT);
P2 = abs(zapcurrent_fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
zapcurrent_powerspectrum=P1;

%% Final Plotting
Z=voltage_powerspectrum./zapcurrent_powerspectrum;
z=smooth(f, Z, 15);

figure('units','normalized','position',[0 0 1 1])
plot(f,z, 'LineWidth', 3, 'Color', 'r');
hold on
plot(f,Z, 'LineWidth', 2, 'Color', 'k');
axis([f0 f1 0 max(Z(find(f<f1)))+5])
set(gca, 'FontSize', 30);
xlabel('Frequency (Hz)', 'FontSize', 36)
ylabel('Impedance (M ohm)', 'FontSize', 36)
% title('Voltage Power Spectrum over ZAP Power Spectrum', 'FontSize', 30);
lgd=legend({'Smoothed Curve', 'Raw Curve'}, 'Units', 'normalized', 'Position', [0.75 0.82 0.075 0.05], 'Box', 'on', 'FontSize', 28, 'Orientation', 'vertical');


str1=sprintf('ImpedancePlot_exp_%d.png', i);
%     saveas(gcf, str1)
set(gcf,'PaperPositionMode','auto')
print(str1, '-dpng', '-r0');


% str1=sprintf('ImpedancePlotDC_%d_%d_%d_%d_%d.png', f0, f1, amp, dur, DC);
% %     saveas(gcf, str1)
% set(gcf,'PaperPositionMode','auto')
% print(str1, '-dpng', '-r0');

%% Plot Traces
figure('units','normalized','position',[0 0 1 .5])
plot(time, voltage, 'LineWidth', 2, 'Color', 'b')
hold on
plot(time, mean(voltage)*ones(1, length(time)), 'LineWidth', 2, 'Color', 'k')
axis([0 20645 min(voltage)-.1 max(voltage)+.1])
set(gca, 'FontSize', 30);
x=xlabel('Time (ms)', 'FontSize', 36);
y=ylabel('Voltage (mV)', 'FontSize', 36);

str1=sprintf('ZapVoltageTrace_exp_%d.png', i);
%     saveas(gcf, str1)
set(gcf,'PaperPositionMode','auto')
print(str1, '-dpng', '-r0');

figure('units','normalized','position',[0 0 1 .5])
plot(time, current, 'LineWidth', 2, 'Color', 'g')
hold on
plot(time, 0*ones(1, length(time)), 'LineWidth', 2, 'Color', 'k')
axis([0 20645 min(current)-.001 max(current)+.001])
set(gca, 'FontSize', 30);
x=xlabel('Time (ms)', 'FontSize', 36);
y=ylabel('Current (nA)', 'FontSize', 36);

str1=sprintf('ZapCurrentTrace_exp_%d.png', i);
%     saveas(gcf, str1)
set(gcf,'PaperPositionMode','auto')
print(str1, '-dpng', '-r0');

end
