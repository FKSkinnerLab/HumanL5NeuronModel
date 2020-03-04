clear
close all

%% Initialize 

numsteps=3000/.1;
fs=10000;
[ap] = sl_sync_params();

%% Fetch data
load('FDG_exp_1.mat');

for i=1:30   
    I=A(:,2,i)*.001; %Convert to nA;
    V=A(:,1,i);
    
    I_cut=I((468/.1):(2560/.1));
    V_cut=V((468/.1):(2560/.1));

    [G, phi_corrected, freq] = freqDepGain(V_cut,I_cut,fs,ap);
    
    %% Final Plotting
    figure('units','normalized','position',[0 0 1 1])
    semilogx(freq, G);
    set(gca, 'FontSize', 20);
    xlabel('Frequency, Hz', 'FontSize', 26)
    ylabel('Gain, Hz/nA', 'FontSize', 26)
    title('Frequency Dependent Gain', 'FontSize', 30);
    axis([0 200 0 1500])
    
    str1=sprintf('FrequencyDependentGain_exp1_%d.png', i);
    %     saveas(gcf, str1)
    set(gcf,'PaperPositionMode','auto')
    print(str1, '-dpng', '-r0');
    
    writematrix=[freq', G'];
    str2=sprintf('FrequencyDependentGain_exp1_%d.csv', i);
    csvwrite(str2, writematrix);
    
    close all
    display(i)
end

%% Averaging
avg=zeros(317,2);
for i=1:30
    str3=sprintf('FrequencyDependentGain_exp1_%d.csv', i);
    temp=csvread(str3);
    avg=avg+temp;
end
avg=avg./30;

figure('units','normalized','position',[0 0 1 1])
semilogx(freq, G);
set(gca, 'FontSize', 20);
xlabel('Frequency, Hz', 'FontSize', 26)
ylabel('Gain, Hz/nA', 'FontSize', 26)
title('Frequency Dependent Gain (Average)', 'FontSize', 30);
axis([0 200 0 1500])
xticks([0 5 10 100 200])
xticklabels({0, 5, 10, 100, 200})

str1=sprintf('FrequencyDependentGain_exp1AVG.png');
%     saveas(gcf, str1)
set(gcf,'PaperPositionMode','auto')
print(str1, '-dpng', '-r0');

writematrix=[freq', G'];
str2=sprintf('FrequencyDependentGain_exp1AVG.csv');
csvwrite(str2, writematrix);

figure('units','normalized','position',[0 0 1 1])
semilogx(freq, G);
set(gca, 'FontSize', 20);
xlabel('Frequency, Hz', 'FontSize', 26)
ylabel('Gain, Hz/nA', 'FontSize', 26)
title('Frequency Dependent Gain (Average)', 'FontSize', 30);
axis([0 50 0 750])
xticks([0 5 10 50])
xticklabels({0, 5, 10, 50})

str1=sprintf('FrequencyDependentGain_exp1AVG_zoom.png');
%     saveas(gcf, str1)
set(gcf,'PaperPositionMode','auto')
print(str1, '-dpng', '-r0');
