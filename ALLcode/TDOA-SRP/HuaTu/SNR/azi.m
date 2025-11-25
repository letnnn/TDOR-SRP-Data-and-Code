%% 数据（方位角结果）
methods = {'SNR 0','SNR 10','SNR 20','SNR 30','No SNR'};
RMSE  = [3.64, 2.82, 2.50, 2.24, 2.27];
MAE   = [2.90, 2.20, 2.00, 1.82, 1.98];

% 颜色
color_rmse = [205, 79, 57]/255;    % 红色
color_mae  = [70, 130, 180]/255;   % 蓝色

figure; hold on;
nMethods = length(methods);
barWidth = 0.28;  
offset = [-barWidth/2, barWidth/2];  
x = 1:nMethods;

%% 左轴（唯一坐标轴）
yyaxis left;
h1 = bar(x+offset(1), RMSE, barWidth, 'FaceColor', color_rmse, 'EdgeColor',[0.7 0.7 0.7]);
hold on;
h2 = bar(x+offset(2), MAE,  barWidth, 'FaceColor', color_mae,  'EdgeColor',[0.7 0.7 0.7]);

ylim([0 5]);
yticks(0:1:5);
ylabel('Angle Error (°)', 'FontName','Times New Roman','FontSize',13);

%% 样式优化
grid on;
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;
ax.FontName = 'Times New Roman';
ax.FontSize = 12;

set(gca, 'XTick', x, 'XTickLabel', methods);
xlabel('SNR (dB)', 'FontName','Times New Roman','FontSize',13);

% 坐标轴颜色
ax.XColor = 'k';
ax.YColor = 'k';
ax.GridColor = [0 0 0];

% 去掉右轴
yyaxis right
set(gca,'YColor','none','YTick',[]);

% 去掉 box 并绘制三条边框
yyaxis left
box(ax,'off');
xl = xlim;
yl = ylim;
line([xl(1) xl(1)], [yl(1) yl(2)], 'Color','k','LineWidth',1);
line([xl(1) xl(2)], [yl(1) yl(1)], 'Color','k','LineWidth',1);
line([xl(2) xl(2)], [yl(1) yl(2)], 'Color','k','LineWidth',1);

%% 图例
legend([h1,h2], {'RMSE','MAE'}, 'FontName','Times New Roman','FontSize',12,'Location','northeast');

%% 图像大小
set(gcf, 'Position', [100, 100, 1800, 600]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

%% 保存为 300 dpi TIFF
print(gcf, 'azi_SNR_comparison.tif','-dtiff','-r300');
