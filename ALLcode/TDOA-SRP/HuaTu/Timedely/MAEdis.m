%% 柱状图

% 数据：GCC-PHAT (RMSE值)
GCC_PHAT = [
0.228	0.2349
0.1525	0.2005
0.2836	0.725
0.2692	0.3591
0.1244	0.3689
0.2224	0.4714
0.2208	0.3343
0.1631	0.3058
0.1549	0.02796
0.1433	0.3069
0.192	0.4165
0.1531	0.2753
0.1646	0.2603
0.0755	0.3221
0.125	0.2616
0.1869	0.2618
0.1641	0.287
0.0636	0.0704
0.196	0.3556
0.126	0.1106
0.1434	0.3039
0.1289	0.2917
0.2072	0.3706
0.094	0.2086
0.2314	0.3786
0.1468	0.363
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
title('MAE', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Data(1-26)', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Sample Index Difference', 'FontSize', 12, 'FontName', 'Times New Roman'); % 添加纵坐标单位

% 设置坐标轴范围
xlim([0.5, 26.5]); % 避免边界数据被截断
ylim([0, 1]); % 设置 y 轴范围

% 设置 y 轴刻度
yticks(0:0.2:2); % 设置 y 轴从 0 到 2，间隔为 0.2

% 显示图例（顺序也要调整）
legend({'GCC-PHAT', 'TDOA-SRP'}, 'Location', 'northeast', 'FontSize', 12, 'FontName', 'Times New Roman');

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
%exportgraphics(gcf, 'MAEdis.png', 'Resolution', 300);
print(gcf, 'MAEtde', '-dtiff', '-r300');
