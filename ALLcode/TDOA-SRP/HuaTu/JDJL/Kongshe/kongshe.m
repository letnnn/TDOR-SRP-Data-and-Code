% %% 横向柱状图（竖着柱子，每个指标对应 RMSE, MAE, MAPE）
% clc; clear; close all;
% 
% % 横坐标类别
% methods = {'Azimuth', 'Elevation', 'Distance'};
% 
% % 数据
% RMSE  = [2.4286, 3.7577, 0.2149];
% MAE   = [2.0844, 3.1463, 0.1878];
% MAPE  = [1.76, 9.03, 9.24];
% 
% % 颜色
% color_rmse = [205, 79, 57]/255;    % 红色
% color_mae  = [70, 130, 180]/255;   % 蓝色
% color_mape = [143, 188, 143]/255;  % 绿色
% 
% nMethods = length(methods);
% barWidth = 0.25;
% offset = [-barWidth, 0, barWidth]; % 三根柱子的偏移量
% x = 1:nMethods;
% 
% figure; hold on;
% 
% % 绘制三组柱状图
% h1 = bar(x+offset(1), RMSE, barWidth, 'FaceColor', color_rmse, 'EdgeColor',[0.7 0.7 0.7]);
% h2 = bar(x+offset(2), MAE,  barWidth, 'FaceColor', color_mae,  'EdgeColor',[0.7 0.7 0.7]);
% h3 = bar(x+offset(3), MAPE, barWidth, 'FaceColor', color_mape, 'EdgeColor',[0.7 0.7 0.7]);
% 
% % 坐标轴和网格
% xlabel('Metrics', 'FontName','Times New Roman','FontSize',13);
% ylabel('Error Value', 'FontName','Times New Roman','FontSize',13);
% set(gca, 'XTick', x, 'XTickLabel', methods, 'FontName','Times New Roman','FontSize',12);
% grid on; 
% ax = gca;
% ax.GridLineStyle = '--';
% ax.LineWidth = 1.2;
% 
% % 图例
% legend([h1,h2,h3], {'RMSE','MAE','MAPE (%)'}, 'FontName','Times New Roman','FontSize',12,'Location','northeast');
% 
% % 调整图像大小
% set(gcf, 'Position', [100, 100, 900, 450]);
% set(gca, 'LooseInset', get(gca, 'TightInset'));
% 
% % 保存图片（300 dpi TIFF格式）
% print(gcf, 'Error_Comparison_VerticalBar', '-dtiff', '-r300');






%% 横向柱状图（竖着柱子，每个指标对应 RMSE, MAE）
% clc; clear; close all;
% 
% % 横坐标类别
% methods = {'Azimuth(°)', 'Elevation(°)', 'Distance(m)'};
% 
% % 数据
% RMSE  = [2.4286, 3.7577, 0.2149];
% MAE   = [2.0844, 3.1463, 0.1878];
% 
% % 颜色
% color_rmse = [205, 79, 57]/255;    % 红色
% color_mae  = [70, 130, 180]/255;   % 蓝色
% 
% nMethods = length(methods);
% barWidth = 0.3;         % 增加柱宽，因只剩两组柱子
% offset = [-barWidth/2, barWidth/2]; % 两根柱子的偏移量
% x = 1:nMethods;
% 
% figure; hold on;
% 
% % 绘制两组柱状图
% h1 = bar(x+offset(1), RMSE, barWidth, 'FaceColor', color_rmse, 'EdgeColor',[0.7 0.7 0.7]);
% h2 = bar(x+offset(2), MAE,  barWidth, 'FaceColor', color_mae,  'EdgeColor',[0.7 0.7 0.7]);
% 
% % 坐标轴和网格
% xlabel('Metrics', 'FontName','Times New Roman','FontSize',13);
% ylabel('Error Value', 'FontName','Times New Roman','FontSize',13);
% set(gca, 'XTick', x, 'XTickLabel', methods, 'FontName','Times New Roman','FontSize',12);
% grid on; 
% ax = gca;
% ax.GridLineStyle = '--';
% ax.LineWidth = 1.2;
% 
% % 图例
% legend([h1,h2], {'RMSE','MAE'}, 'FontName','Times New Roman','FontSize',12,'Location','northeast');
% 
% % 调整图像大小
% set(gcf, 'Position', [100, 100, 900, 450]);
% set(gca, 'LooseInset', get(gca, 'TightInset'));
% 
% % 保存图片（300 dpi TIFF格式）
% print(gcf, 'Error_Comparison_RMSE_MAE', '-dtiff', '-r300');



%% 横向柱状图（左轴 RMSE/MAE，右轴 MAPE）
clc; clear; close all;

methods = {'Azimuth(°)', 'Elevation(°)', 'Distance(m)'};
RMSE  = [2.5649, 3.7238, 0.1902];
MAE   = [2.2513, 3.0393, 0.1606];
MAPE  = [0, 0, 7.92];

color_rmse = [205, 79, 57]/255;   % 红色
color_mae  = [70, 130, 180]/255;  % 蓝色
color_mape = [143, 188, 143]/255; % 绿色

edge_color = [0.7 0.7 0.7];
edge_width = 1.2;
barWidth = 0.25;
x = 1:length(methods);

figure; hold on;

%% ======== 左轴：RMSE + MAE ========
yyaxis left
ylim([0 5]); yticks(0:1:5); set(gca,'YColor','k')
ylabel('Error Value (RMSE / MAE)','FontName','Times New Roman','FontSize',13)

offsets_12 = [-barWidth/2, barWidth/2];
for i = 1:2
    bar(x(i)+offsets_12(1), RMSE(i), barWidth, 'FaceColor', color_rmse, 'EdgeColor', edge_color, 'LineWidth', edge_width);
    bar(x(i)+offsets_12(2), MAE(i), barWidth, 'FaceColor', color_mae, 'EdgeColor', edge_color, 'LineWidth', edge_width);
end

offsets_3 = [-barWidth, 0];
bar(x(3)+offsets_3(1), RMSE(3), barWidth, 'FaceColor', color_rmse, 'EdgeColor', edge_color, 'LineWidth', edge_width);
bar(x(3)+offsets_3(2), MAE(3), barWidth, 'FaceColor', color_mae, 'EdgeColor', edge_color, 'LineWidth', edge_width);

%% ======== 右轴：MAPE ========
yyaxis right
ylim([0 10]); yticks(0:2:10); set(gca,'YColor','k')
ylabel('MAPE (%)','FontName','Times New Roman','FontSize',13)
bar(x(3)+barWidth, MAPE(3), barWidth, 'FaceColor', color_mape, 'EdgeColor', edge_color, 'LineWidth', edge_width);

%% ======== 横坐标标签对齐 ========
xticks_12 = x(1:2); xtick_3 = x(3);
set(gca, 'XTick', [xticks_12, xtick_3], 'XTickLabel', methods, 'FontName','Times New Roman','FontSize',12);

%% ======== 样式 ========
grid on; ax = gca; ax.GridLineStyle='--'; ax.LineWidth=1.2;

%% ======== 修正图例颜色 ========
% 使用隐藏柱对象，保证颜色正确
h1 = bar(NaN,NaN,'FaceColor',color_rmse,'EdgeColor',edge_color);
h2 = bar(NaN,NaN,'FaceColor',color_mae,'EdgeColor',edge_color);
h3 = bar(NaN,NaN,'FaceColor',color_mape,'EdgeColor',edge_color);
legend([h1,h2,h3], {'RMSE','MAE','MAPE'}, 'FontName','Times New Roman','FontSize',12,'Location','northeast');

%% ======== 图像大小与保存 ========
set(gcf, 'Position', [100,100,900,450]);
set(gca, 'LooseInset', get(gca, 'TightInset'))
print(gcf, 'Error_Comparison_DualAxis', '-dtiff', '-r300');
 