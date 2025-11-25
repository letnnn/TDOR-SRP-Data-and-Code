%% 柱状图

% 数据：GCC-PHAT (RMSE值)
GCC_PHAT = [
0.1778	0.0074
0.0419	0.2387
0.2738	0.5401
0.6967	0.5313
0.6649	0.2511
0.2827	0.9743
0.3244	0.2598
0.0834	0.1105
0.2043	0.1321
0.5435	0.228
0.3567	0.4595
0.2897	0.2701
0.386	0.9153
0.3641	0.9465
0.0974	0.0539
0.0249	0.1471
0.1022	0.3925
0.1158	0.0387
0.262	0.6846
0.2591	0.7547
0.1535	0.3004
0.2442	1.1004
0.2017	1.6351
0.1833	0.4023
0.2131	0.241
0.2818	1.6167
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
title('RMSE', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Data(1-26)', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Distance Error(m)', 'FontSize', 12, 'FontName', 'Times New Roman'); % 添加纵坐标单位

% 设置坐标轴范围
xlim([0.5, 26.5]); % 避免边界数据被截断
ylim([0, 2]); % 设置 y 轴范围

% 设置 y 轴刻度
yticks(0:0.2:2); % 设置 y 轴从 0 到 2，间隔为 0.2

% 显示图例（顺序也要调整）
legend({'TDOA', 'TDOA-SRP'}, 'Location', 'northeast', 'FontSize', 12, 'FontName', 'Times New Roman');

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
%exportgraphics(gcf, 'RMSEdis.png', 'Resolution', 300);
print(gcf, 'RMSEdis', '-dtiff', '-r300');

