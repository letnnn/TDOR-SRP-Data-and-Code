% %% Performance Comparison of Different Methods (Dual-axis style, tight bars)
% % 数据
% x = 1:3;  % 对应 RMSE, MAE, MAPE
% GCC_PHAT   = [0.3176, 0.3027, 32.58];
% PGCC_PHAT  = [0.7954, 0.5705, 55.53];
% MGCCFF     = [0.5341, 0.4003, 49.66];
% OUR        = [0.1759, 0.1677, 18.15];
% 
% % 颜色
% color_gcc  = [143, 188, 143] / 255;  % 绿色
% color_pgcc = [106, 90, 205] / 255;  % 紫色
% color_mgcc = [70, 130, 180] / 255;   % 蓝色
% color_our  = [205, 79, 57] / 255;    % 红色
% 
% figure; hold on;
% 
% %% ==== 左轴：RMSE & MAE ====
% yyaxis left;
% barWidth = 0.22;  % 调整柱宽
% offset = [-1.5, -0.5, 0.5, 1.5] * barWidth;  % 每组柱子偏移
% 
% for i = 1:2  % RMSE & MAE
%     bar(x(i)+offset(1), GCC_PHAT(i), barWidth, 'FaceColor', color_gcc, 'EdgeColor', [0.7 0.7 0.7]);
%     bar(x(i)+offset(2), PGCC_PHAT(i), barWidth, 'FaceColor', color_pgcc, 'EdgeColor', [0.7 0.7 0.7]);
%     bar(x(i)+offset(3), MGCCFF(i),    barWidth, 'FaceColor', color_mgcc, 'EdgeColor', [0.7 0.7 0.7]);
%     bar(x(i)+offset(4), OUR(i),       barWidth, 'FaceColor', color_our,  'EdgeColor', [0.7 0.7 0.7]);
% end
% 
% ylim([0 1]);
% yticks(0:0.2:1);  % 左轴刻度
% ylabel('RMSE / MAE', 'FontName', 'Times New Roman', 'FontSize', 13);
% 
% %% ==== 右轴：MAPE ====
% yyaxis right;
% for i = 3  % MAPE
%     bar(x(i)+offset(1), GCC_PHAT(i), barWidth, 'FaceColor', color_gcc, 'EdgeColor', [0.7 0.7 0.7]);
%     bar(x(i)+offset(2), PGCC_PHAT(i), barWidth, 'FaceColor', color_pgcc, 'EdgeColor', [0.7 0.7 0.7]);
%     bar(x(i)+offset(3), MGCCFF(i),    barWidth, 'FaceColor', color_mgcc, 'EdgeColor', [0.7 0.7 0.7]);
%     bar(x(i)+offset(4), OUR(i),       barWidth, 'FaceColor', color_our,  'EdgeColor', [0.7 0.7 0.7]);
% end
% 
% ylim([0 100]);
% yticks(0:20:100);  % 右轴刻度
% yticklabels({'0','20','40','60','80','100'});  % 去掉百分号
% ylabel('MAPE', 'FontName', 'Times New Roman', 'FontSize', 13);
% 
% %% ====== 样式优化 ======
% grid on;
% ax = gca;
% ax.GridLineStyle = '--';
% ax.LineWidth = 1.2;
% ax.FontName = 'Times New Roman';
% ax.FontSize = 12;
% set(gca, 'XTick', x, 'XTickLabel', {'RMSE','MAE','MAPE'});
% xlabel('Evaluation Metrics', 'FontName', 'Times New Roman', 'FontSize', 13);
% 
% % 坐标轴颜色
% ax.XColor = 'k';
% ax.YColor = 'k';
% ax.YAxis(1).Color = 'k';
% ax.YAxis(2).Color = 'k';
% ax.GridColor = [0 0 0];
% 
% % 去掉默认 box 并绘制左/下/右三条实线边框
% box(ax,'off');
% xl = xlim;
% yyaxis left;
% yl_left = ylim;
% hold on;
% line([xl(1) xl(1)], [yl_left(1) yl_left(2)], 'Color','k','LineWidth',1); % 左
% line([xl(1) xl(2)], [yl_left(1) yl_left(1)], 'Color','k','LineWidth',1); % 底
% line([xl(2) xl(2)], [yl_left(1) yl_left(2)], 'Color','k','LineWidth',1); % 右
% hold off;
% 
% %% 图例
% legend({'GCC-PHAT','PGCC-PHAT','MGCCFF','TDOA-SRP'}, ...
%     'FontName','Times New Roman','FontSize',12,'Location','northeast');
% 
% %% 设置图像大小
% set(gcf, 'Position', [100, 100, 1500, 600]);
% set(gca, 'LooseInset', get(gca, 'TightInset'));
% 
% %% 保存为 300 dpi TIFF
% print(gcf, 'performance_comparison_bar_dualaxis_tight.tif', '-dtiff', '-r300');















%%

%% 数据
methods = {'GCC-PHAT','PGCC-PHAT','MGCCFF','TDOA-SRP'};
RMSE  = [0.3176, 0.7954, 0.5341, 0.1759];
MAE   = [0.3027, 0.5705, 0.4003, 0.1677];
MAPE  = [32.58, 55.53, 49.66, 18.15];

% 颜色
color_rmse = [205, 79, 57]/255;    % 红色
color_mae  = [70, 130, 180]/255;   % 蓝色
color_mape = [143, 188, 143] / 255;  % 紫色

figure; hold on;
nMethods = length(methods);
barWidth = 0.25;
offset = [-barWidth, 0, barWidth]; % 三个指标的偏移量
x = 1:nMethods;

%% 左轴: RMSE & MAE
yyaxis left;
h1 = bar(x+offset(1), RMSE, barWidth, 'FaceColor', color_rmse, 'EdgeColor',[0.7 0.7 0.7]);
h2 = bar(x+offset(2), MAE,  barWidth, 'FaceColor', color_mae,  'EdgeColor',[0.7 0.7 0.7]);
ylim([0 1]);
yticks(0:0.2:1);
ylabel('Sample Index Difference', 'FontName','Times New Roman','FontSize',13);

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
set(gca, 'XTick', x, 'XTickLabel', methods);
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

%% 图例（手动指定句柄）
legend([h1,h2,h3], {'RMSE','MAE','MAPE'}, 'FontName','Times New Roman','FontSize',12,'Location','northeast');

%% 设置图像大小
set(gcf, 'Position', [100, 100, 1500, 600]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

%% 保存为 300 dpi TIFF
print(gcf, 'MLTDE.tif','-dtiff','-r300');
