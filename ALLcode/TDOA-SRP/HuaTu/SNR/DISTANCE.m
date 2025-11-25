%% 数据（按 SNR）
methods = {'SNR 0','SNR 10','SNR 20','SNR 30','No SNR'};
RMSE  = [0.35, 0.31, 0.3, 0.28, 0.26];
MAE   = [0.32, 0.29, 0.28, 0.26, 0.24];
MAPE  = [15.97, 14.39, 13.85, 12.96, 10.88];

% 颜色
color_rmse = [205, 79, 57]/255;    % 红色
color_mae  = [70, 130, 180]/255;   % 蓝色
color_mape = [143, 188, 143]/255;  % 绿色

figure; hold on;
nMethods = length(methods);
barWidth = 0.2;  
totalBarWidth = barWidth*3;  
offset = [-barWidth, 0, barWidth];  
x = 1:nMethods;

%% 左轴: RMSE & MAE
yyaxis left;
h1 = bar(x+offset(1), RMSE, barWidth, 'FaceColor', color_rmse, 'EdgeColor',[0.7 0.7 0.7]);
h2 = bar(x+offset(2), MAE,  barWidth, 'FaceColor', color_mae,  'EdgeColor',[0.7 0.7 0.7]);
ylim([0 0.5]);
yticks(0:0.1:0.5);
ylabel('Distance Error (m)', 'FontName','Times New Roman','FontSize',13);

%% 右轴: MAPE
yyaxis right;
h3 = bar(x+offset(3), MAPE, barWidth, 'FaceColor', color_mape, 'EdgeColor',[0.7 0.7 0.7]);
ylim([0 20]);
yticks(0:5:20);
yticklabels({'0','5','10','15','20'});
ylabel('', 'FontName','Times New Roman','FontSize',13);

%% 样式优化
grid on;
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;
ax.FontName = 'Times New Roman';
ax.FontSize = 12;

set(gca, 'XTick', x, 'XTickLabel', methods);
ax.XTickLabelRotation = 0;
xlabel('SNR (dB)', 'FontName','Times New Roman','FontSize',13);

ax.XColor = 'k';
ax.YColor = 'k';
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
ax.GridColor = [0 0 0];

box(ax,'off');
xl = xlim;
yyaxis left;
yl_left = ylim;
hold on;
line([xl(1) xl(1)], [yl_left(1) yl_left(2)], 'Color','k','LineWidth',1);
line([xl(1) xl(2)], [yl_left(1) yl_left(1)], 'Color','k','LineWidth',1);
line([xl(2) xl(2)], [yl_left(1) yl_left(2)], 'Color','k','LineWidth',1);
hold off;

%% 图例
legend([h1,h2,h3], {'RMSE','MAE','MAPE'}, 'FontName','Times New Roman','FontSize',12,'Location','northeast');

%% 图像大小
set(gcf, 'Position', [100, 100, 1800, 600]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

%% 保存为 300 dpi TIFF
print(gcf, 'dis_SNR_comparison.tif','-dtiff','-r300');
