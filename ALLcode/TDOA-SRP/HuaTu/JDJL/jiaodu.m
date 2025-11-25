% %% 方位角
% % 数据
% data = [
%     1   2.5   4.5;
%     2   1     1.5;
%     0   11    16;
%     0   3     2;
%     1   1     4;
%     3   3.5   14;
%     2.5 7.5   18;
%     5   4.5   4.5;
%     5   4     9;
%     1   4.5   5;
%     2   4.5   8.5;
%     1   1     1;
%     0.5 0     2;
%     1   1     4;
%     1   1     0;
%     0   1     0;
%     1   2     1;
%     1.5 1.5   1;
%     4   3    11;
%     5   2     6;
%     3   3.5   2.5;
%     2   1.5   2;
%     0   1    10.5;
%     0   1     9;
%     3   6.5   12;
%     1   2.5   4
% ];
% 
% % 提取三列误差数据
% method_our = data(:,1);     % 本文方法
% method_tdoa_improved = data(:,2); % 改进 TDOA
% method_tdoa_original = data(:,3); % 原始 TDOA
% 
% % 横坐标：数据点编号
% x = 1:26;  % 只显示前26个数据点
% 
% % 绘制方位角折线图
% figure;
% hold on;
% plot(x, method_our(x), '-o', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [205/255, 79/255, 57/255]); % 本文方法（红色）
% plot(x, method_tdoa_improved(x), '-s', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [79/255, 148/255, 205/255]); % 改进TDOA（蓝色）
% plot(x, method_tdoa_original(x), '-d', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [124/255, 205/255, 124/255]); % 原始TDOA（浅绿色）
% hold off;
% 
% % 添加网格
% grid on;
% 
% % 轴标签
% xlabel('Data（1-26）');
% ylabel('Degree（°）');
% 
% % 标题
% title('Azimuth');
% 
% % 图例
% legend('Now', 'Improved TDOA', 'TDOA');
% 
% % 调整图像大小
% set(gcf, 'Position', [100, 100, 800, 500]); % 设置图像大小
% 
% % 保存为高质量图片
% saveas(gcf, 'angle_error_comparison.png');  % 保存为 PNG
% print(gcf, 'angle_error_comparison.pdf', '-dpdf', '-r300'); % 使用 print 保存为 PDF，分辨率300DPI
% 
% 
% %% 俯仰角
% % 数据
% data = [
%    8	8.5	6;
%    4.5	4	7;
%    2.5	2	8;
%    0	17	20.5;
%    2	3	6.5;
%    3	5.5	6;
%    1	1.5	0.5;
%    1	7	9.34;
%    1	5	6;
%    3.5	3.5	5.5;
%    2	5	8.5;
%    2.5	5	2;
%    1	3	8.5;
%    5	1	9.5;
%    3.5	2.5	2;
%    4	4.5	1;
%    3	5	12;
%    0.5	0.5	2.5;
%    3	4.5	3;
%    2	3	2;
%    0.5	4	8.5;
%    3	2.5	12.5;
%    1.5	5	1;
%    1	2.5	3.5;
%    2	5	7;
%    1	4.5	2.5
% ];
% 
% % 提取三列误差数据
% method_our = data(:,1);     % 本文方法
% method_tdoa_improved = data(:,2); % 改进 TDOA
% method_tdoa_original = data(:,3); % 原始 TDOA
% 
% % 横坐标：数据点编号
% x = 1:26;  % 只显示前26个数据点
% 
% % 绘制俯仰角折线图
% figure;
% hold on;
% plot(x, method_our(x), '-o', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [205/255, 79/255, 57/255]); % 本文方法（红色）
% plot(x, method_tdoa_improved(x), '-s', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [79/255, 148/255, 205/255]); % 改进TDOA（蓝色）
% plot(x, method_tdoa_original(x), '-d', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [124/255, 205/255, 124/255]); % 原始TDOA（浅绿色）
% hold off;
% 
% % 添加网格
% grid on;
% 
% % 轴标签
% xlabel('Data（1-26）');
% ylabel('Degree（°）');
% 
% % 标题
% title('Elevation');
% 
% % 图例
% legend('Now', 'Improved TDOA', 'TDOA');
% 
% % 调整图像大小
% set(gcf, 'Position', [100, 100, 800, 500]); % 设置图像大小
% 
% % 保存为高质量图片
% saveas(gcf, 'angle_error_comparison.png');  % 保存为 PNG
% print(gcf, 'ELE_angle_error_comparison.pdf', '-dpdf', '-r300'); % 使用 print 保存为 PDF，分辨率300DPI






% %% 方位角误差对比柱状图
% % 数据
% data_azimuth = [
%     1   2.5   4.5;
%     2   1     1.5;
%     0   11    16;
%     0   3     2;
%     1   1     4;
%     3   3.5   14;
%     2.5 7.5   18;
%     5   4.5   4.5;
%     5   4     9;
%     1   4.5   5;
%     2   4.5   8.5;
%     1   1     1;
%     0.5 0     2;
%     1   1     4;
%     1   1     0;
%     0   1     0;
%     1   2     1;
%     1.5 1.5   1;
%     4   3    11;
%     5   2     6;
%     3   3.5   2.5;
%     2   1.5   2;
%     0   1    10.5;
%     0   1     9;
%     3   6.5   12;
%     1   2.5   4
% ];
% 
% % 提取误差数据
% method_our = data_azimuth(:,1);     
% method_tdoa_improved = data_azimuth(:,2); 
% method_tdoa_original = data_azimuth(:,3); 
% 
% % 横坐标：数据点编号
% x = 1:26;
% 
% % 绘制柱状图
% figure;
% hold on;
% bar(x - 0.15, method_tdoa_original, 'FaceColor', [143/255, 188/255, 143/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);
% bar(x + 0.15, method_tdoa_improved, 'FaceColor', [70/255, 130/255, 180/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);
% bar(x + 0.45, method_our, 'FaceColor', [205/255, 79/255, 57/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);
% hold off;
% 
% % 添加网格
% grid on;
% ax = gca;
% ax.GridLineStyle = '--'; % 设置网格线为虚线
% 
% % 轴标签
% xlabel('Data(1-26)', 'FontName', 'Times New Roman');
% ylabel('Degree(°)', 'FontName', 'Times New Roman');
% 
% % 标题
% title('Azimuth Angle Error Comparison', 'FontName', 'Times New Roman');
% 
% % 设置横坐标刻度
% xticks(1:26);
% 
% % 图例
% legend('TDOA', 'Improved TDOA', 'Now', 'FontName', 'Times New Roman');
% 
% % 调整图像大小
% set(gcf, 'Position', [100, 100, 1800, 600]);  % 增大图像窗口
% 
% % 保存为高质量图片
% saveas(gcf, 'azimuth_angle_error_comparison_bar.png');  
% print(gcf, 'azimuth_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项
% 
% 
% %% 俯仰角误差对比柱状图
% % 数据
% data_elevation = [
%    8    8.5  6;
%    4.5  4    7;
%    2.5  2    8;
%    0    17   20.5;
%    2    3    6.5;
%    3    5.5  6;
%    1    1.5  0.5;
%    1    7    9.34;
%    1    5    6;
%    3.5  3.5  5.5;
%    2    5    8.5;
%    2.5  5    2;
%    1    3    8.5;
%    5    1    9.5;
%    3.5  2.5  2;
%    4    4.5  1;
%    3    5    12;
%    0.5  0.5  2.5;
%    3    4.5  3;
%    2    3    2;
%    0.5  4    8.5;
%    3    2.5  12.5;
%    1.5  5    1;
%    1    2.5  3.5;
%    2    5    7;
%    1    4.5  2.5
% ];
% 
% % 提取误差数据
% method_our = data_elevation(:,1);     
% method_tdoa_improved = data_elevation(:,2); 
% method_tdoa_original = data_elevation(:,3); 
% 
% % 横坐标：数据点编号
% x = 1:26;
% 
% % 绘制柱状图
% figure;
% hold on;
% bar(x - 0.15, method_tdoa_original, 'FaceColor', [143/255, 188/255, 143/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);
% bar(x + 0.15, method_tdoa_improved, 'FaceColor', [70/255, 130/255, 180/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);
% bar(x + 0.45, method_our, 'FaceColor', [205/255, 79/255, 57/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);
% hold off;
% 
% % 添加网格
% grid on;
% ax = gca;
% ax.GridLineStyle = '--'; % 设置网格线为虚线
% 
% % 轴标签
% xlabel('Data(1-26)', 'FontName', 'Times New Roman');
% ylabel('Degree(°)', 'FontName', 'Times New Roman');
% 
% % 标题
% title('Elevation Angle Error Comparison', 'FontName', 'Times New Roman');
% 
% % 设置横坐标刻度
% xticks(1:26);
% 
% % 图例
% legend('TDOA', 'Improved TDOA', 'Now', 'FontName', 'Times New Roman');
% 
% % 调整图像大小
% set(gcf, 'Position', [100, 100, 1800, 600]);  % 增大图像窗口
% 
% % 保存为高质量图片
% saveas(gcf, 'elevation_angle_error_comparison_bar.png');  
% print(gcf, 'elevation_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项









%% 方位角误差对比柱状图
% 数据
data_azimuth = [
    1   2.5   4.5;
    2   1     1.5;
    0   11    16;
    0   3     2;
    1   1     4;
    3   3.5   14;
    2.5 7.5   18;
    5   4.5   4.5;
    5   4     9;
    1   4.5   5;
    2   4.5   8.5;
    1   1     1;
    0.5 0     2;
    1   1     4;
    1   1     0;
    0   1     0;
    1   2     1;
    1.5 1.5   1;
    4   3    11;
    5   2     6;
    3   3.5   2.5;
    2   1.5   2;
    0   1    10.5;
    0   1     9;
    3   6.5   12;
    1   2.5   4
];

% 提取误差数据
method_our = data_azimuth(:,1);     
method_tdoa_improved = data_azimuth(:,2); 
method_tdoa_original = data_azimuth(:,3); 

% 横坐标：数据点编号
x = 1:26;

% 设置柱状图的高度为零的值
method_our(method_our == 0) = NaN;
method_tdoa_improved(method_tdoa_improved == 0) = NaN;
method_tdoa_original(method_tdoa_original == 0) = NaN;

% 绘制柱状图
figure;
hold on;
bar(x - 0.15, method_tdoa_original, 'FaceColor', [143/255, 188/255, 143/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);  % 设置更粗的柱子
bar(x + 0.15, method_tdoa_improved, 'FaceColor', [70/255, 130/255, 180/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);  % 设置更粗的柱子
bar(x + 0.45, method_our, 'FaceColor', [205/255, 79/255, 57/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);  % 设置更粗的柱子
hold off;

% 添加网格
grid on;
ax = gca;
ax.GridLineStyle = '--'; % 设置网格线为虚线

% 轴标签
xlabel('Data(1-26)', 'FontName', 'Times New Roman', 'FontSize', 12);
ylabel('Degree(°)', 'FontName', 'Times New Roman', 'FontSize', 12);

% 标题
title('Azimuth Angle Error Comparison', 'FontName', 'Times New Roman', 'FontSize', 12);

% 设置横坐标刻度
xticks(1:26);

% 调整纵坐标的刻度线长度
ax.XAxis.TickLength = [0.004, 0.004];  % 横坐标刻度线长度
ax.YAxis.TickLength = [0.004, 0.004];  % 纵坐标刻度线长度

% 设置纵坐标范围为0到25，步长为5
ylim([0 25]);
yticks(0:5:25);

% 图例
legend('TDOA', 'Improved TDOA', 'Now', 'FontName', 'Times New Roman', 'FontSize', 12);

% 调整图像大小，减少两边空白
set(gcf, 'Position', [100, 100, 1500, 600]);  % 减少宽度以减少空白
set(gca, 'LooseInset', get(gca, 'TightInset')); % 去除空白区域

% 保存为高质量图片
saveas(gcf, 'azimuth_angle_error_comparison_bar.png');  
print(gcf, 'azimuth_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项


%% 俯仰角误差对比柱状图
% % 数据
% data_elevation = [
%    8    8.5  6;
%    4.5  4    7;
%    2.5  2    8;
%    0    17   20.5;
%    2    3    6.5;
%    3    5.5  6;
%    1    1.5  0.5;
%    1    7    9.34;
%    1    5    6;
%    3.5  3.5  5.5;
%    2    5    8.5;
%    2.5  5    2;
%    1    3    8.5;
%    5    1    9.5;
%    3.5  2.5  2;
%    4    4.5  1;
%    3    5    12;
%    0.5  0.5  2.5;
%    3    4.5  3;
%    2    3    2;
%    0.5  4    8.5;
%    3    2.5  12.5;
%    1.5  5    1;
%    1    2.5  3.5;
%    2    5    7;
%    1    4.5  2.5
% ];
% 
% % 提取误差数据
% method_our = data_elevation(:,1);     
% method_tdoa_improved = data_elevation(:,2); 
% method_tdoa_original = data_elevation(:,3); 
% 
% % 横坐标：数据点编号
% x = 1:26;
% 
% % 设置柱状图的高度为零的值
% method_our(method_our == 0) = NaN;
% method_tdoa_improved(method_tdoa_improved == 0) = NaN;
% method_tdoa_original(method_tdoa_original == 0) = NaN;
% 
% % 绘制柱状图
% figure;
% hold on;
% bar(x - 0.15, method_tdoa_original, 'FaceColor', [143/255, 188/255, 143/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);  % 设置更粗的柱子
% bar(x + 0.15, method_tdoa_improved, 'FaceColor', [70/255, 130/255, 180/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);  % 设置更粗的柱子
% bar(x + 0.45, method_our, 'FaceColor', [205/255, 79/255, 57/255], 'EdgeColor', [0.7, 0.7, 0.7], 'BarWidth', 0.3);  % 设置更粗的柱子
% hold off;
% 
% % 添加网格
% grid on;
% ax = gca;
% ax.GridLineStyle = '--'; % 设置网格线为虚线
% 
% % 轴标签
% xlabel('Data(1-26)', 'FontName', 'Times New Roman', 'FontSize', 12);
% ylabel('Degree(°)', 'FontName', 'Times New Roman', 'FontSize', 12);
% 
% % 标题
% title('Elevation Angle Error Comparison', 'FontName', 'Times New Roman', 'FontSize', 12);
% 
% % 设置横坐标刻度
% xticks(1:26);
% 
% % 调整纵坐标的刻度线长度
% ax.XAxis.TickLength = [0.004, 0.004];  % 横坐标刻度线长度
% ax.YAxis.TickLength = [0.004, 0.004];  % 纵坐标刻度线长度
% 
% % 设置纵坐标范围为0到25，步长为5
% ylim([0 25]);
% yticks(0:5:25);
% 
% % 图例
% legend('TDOA', 'Improved TDOA', 'Now', 'FontName', 'Times New Roman', 'FontSize', 12);
% 
% % 调整图像大小，减少两边空白
% set(gcf, 'Position', [100, 100, 1500, 600]);  % 减少宽度以减少空白
% set(gca, 'LooseInset', get(gca, 'TightInset')); % 去除空白区域
% 
% % 保存为高质量图片
% saveas(gcf, 'elevation_angle_error_comparison_bar.png');  
% print(gcf, 'elevation_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项
