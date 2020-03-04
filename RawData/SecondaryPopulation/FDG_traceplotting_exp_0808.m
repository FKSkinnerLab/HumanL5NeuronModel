clear
close all

%% Initialize

numsteps=3000/.1;
fs=10000;
[ap] = sl_sync_params();

%% Fetch data
load('FDG_exp_1.mat');
numsweeps=10;

avg=zeros(317,2);
for i=1:numsweeps
    I=A(:,2,i)*.001; %Convert to nA;
    V=A(:,1,i);
    time=.1:.1:3000;
    
    %% Plot Traces
    figure('units','normalized','position',[0 0 1 .5])
    plot(time, V, 'LineWidth', 2, 'Color', 'b')
    axis([0 2500 min(V)-.1 max(V)+.1])
    set(gca, 'FontSize', 30);
    x=xlabel('Time (ms)', 'FontSize', 36);
    y=ylabel('Voltage (mV)', 'FontSize', 36);
    
    str1=sprintf('FDGVoltageTrace_exp1new_%d.png', i);
    %     saveas(gcf, str1)
    set(gcf,'PaperPositionMode','auto')
    print(str1, '-dpng', '-r0');
    
    figure('units','normalized','position',[0 0 1 .5])
    plot(time, I, 'LineWidth', 2, 'Color', 'g')
    axis([0 2500 min(I)-.001 max(I)+.001])
    set(gca, 'FontSize', 30);
    x=xlabel('Time (ms)', 'FontSize', 36);
    y=ylabel('Current (nA)', 'FontSize', 36);
    
    str1=sprintf('FDGCurrentTrace_exp1new_%d.png', i);
    %     saveas(gcf, str1)
    set(gcf,'PaperPositionMode','auto')
    print(str1, '-dpng', '-r0');
    
end
