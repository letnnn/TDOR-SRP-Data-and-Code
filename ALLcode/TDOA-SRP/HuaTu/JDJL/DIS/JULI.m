%% 柱状图

% 数据：GCC-PHAT (RMSE值)
GCC_PHAT = [
    0.17	0
    0.12	0.24
    0.27	0.54
    0.69	0.53
    0.65	0.26
    0.29	0.97
    0.2	    0.13
    0.09	0.11
    0.09	0.13
    0.53	0.18
    0.36	0.44
    0.24	0.27
    0.22	0.91
    0.34	0.95
    0.09	0.05
    0.02	0.15
    0.1	    0.39
    0.11	0.04
    0.09	0
    0.18	0.75
    0.15	0.29
    0.21	0.39
    0.01	1.53
    0.12	0.4
    0.11	0.24
    0.2	    1.65
];

% 交换列顺序，使得先绘制 GCC-PHAT（原始），后绘制 Improved GCC-PHAT
GCC_PHAT = GCC_PHAT(:, [2, 1]);

% 横坐标：1到26，每组对应一个x值
x = 1:26;

% 创建图形窗口并调整大小
figure('Position', [100, 100, 1000, 400]); % 宽1000，高400，成长方形

% 绘制柱状图（按行分组，每个x有两根柱子），增加 BarWidth 参数
bar_handle = bar(x, GCC_PHAT, 'grouped', 'BarWidth', 1); % 调整柱子宽度

% 设置颜色（交换后颜色也要对应）
bar_handle(2).FaceColor = [205/255, 79/255, 57/255];   % Tomato3 (GCC-PHAT)
bar_handle(1).FaceColor = [70/255, 130/255, 180/255];  % SteelBlue3 (Improved GCC-PHAT)

% 设置柱状图的轮廓颜色
bar_handle(1).EdgeColor = [0.8, 0.8, 0.8]; % 设置浅灰色轮廓
bar_handle(2).EdgeColor = [0.8, 0.8, 0.8]; % 设置浅灰色轮廓

% 设置图表标题和轴标签
title('Distance', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Data(1-26)', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Meter (m)', 'FontSize', 12, 'FontName', 'Times New Roman'); % 添加纵坐标单位

% 设置坐标轴范围
xlim([0.5, 26.5]); % 避免边界数据被截断
ylim([0, 2]); % 设置 y 轴范围

% 设置 y 轴刻度
yticks(0:0.2:2); % 设置 y 轴从 0 到 2，间隔为 0.2

% 显示图例（顺序也要调整）
legend({'GCC-PHAT', 'Improved GCC-PHAT'}, 'Location', 'northeast', 'FontSize', 12, 'FontName', 'Times New Roman');

% 添加网格并调整样式
grid on;
set(gca, 'GridLineStyle', '--', 'GridColor', [0.5, 0.5, 0.5]);

% 调整纵坐标刻度线的长度，使其变短
set(gca, 'TickLength', [0.004, 0.004]); 
% 去除上侧和右侧的刻度
set(gca, 'Box', 'off');  % 去除坐标轴框
set(gca, 'TickDir', 'in');  % 刻度线朝向内侧

% 设置字体为新罗马字体
set(gca, 'FontName', 'Times New Roman');

% 保存高分辨率图片
exportgraphics(gcf, 'JULI.png', 'Resolution', 300);
