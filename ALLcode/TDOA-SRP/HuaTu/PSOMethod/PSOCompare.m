%% 数据
methods = {'TDOA-SRP','LM','DE','SA','Multi-Start PSO','Global Search'};
RMSE  = [0.2626, 0.99727, 0.4069, 0.6359, 0.6479, 0.41];
MAE   = [0.2419, 0.9809, 0.3619, 0.5738, 0.6156, 0.39];
MAPE  = [10.88, 45.29, 15.96, 24.88, 27.74, 18.55];

% 颜色
color_rmse = [205, 79, 57]/255;    % 红色
color_mae  = [70, 130, 180]/255;   % 蓝色
color_mape = [143, 188, 143] / 255;  % 绿色

figure; hold on;
nMethods = length(methods);
barWidth = 0.2;  
% 每组柱子总宽度
totalBarWidth = barWidth*3;  
% 偏移：使三种指标在一组中居中
offset = [-barWidth, 0, barWidth];  
x = 1:nMethods;

%% 左轴: RMSE & MAE
yyaxis left;
h1 = bar(x+offset(1), RMSE, barWidth, 'FaceColor', color_rmse, 'EdgeColor',[0.7 0.7 0.7]);
h2 = bar(x+offset(2), MAE,  barWidth, 'FaceColor', color_mae,  'EdgeColor',[0.7 0.7 0.7]);
ylim([0 1]);
yticks(0:0.2:1);
ylabel('Distance Error (m)', 'FontName','Times New Roman','FontSize',13);

%% 右轴: MAPE
yyaxis right;
h3 = bar(x+offset(3), MAPE, barWidth, 'FaceColor', color_mape, 'EdgeColor',[0.7 0.7 0.7]);
ylim([0 100]);
yticks(0:20:100);
yticklabels({'0','20','40','60','80','100'});
ylabel('', 'FontName','Times New Roman','FontSize',13);

%% 样式优化
grid on;
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;
ax.FontName = 'Times New Roman';
ax.FontSize = 12;

% 设置 X 轴标签居中在每组柱子上
set(gca, 'XTick', x, 'XTickLabel', methods);
ax.XTickLabelRotation = 0;
xlabel('Methods', 'FontName','Times New Roman','FontSize',13);

% 坐标轴颜色
ax.XColor = 'k';
ax.YColor = 'k';
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
ax.GridColor = [0 0 0];

% 去掉 box 并绘制左/下/右三条实线边框
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
print(gcf, 'MLTDE_updated_centered.tif','-dtiff','-r300');
