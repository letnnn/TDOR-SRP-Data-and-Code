%% 柱状图

% 数据：GCC-PHAT (RMSE值)
GCC_PHAT = [
0.2292	0.2687
0.1558	0.2103
0.2842	0.725
0.2714	0.3591
0.1256	0.3689
0.2241	0.4715
0.2278	0.3639
0.1646	0.3058
0.1553	0.2796
0.1446	0.3335
0.1996	0.4201
0.1635	0.2753
0.3119	0.2603
0.0822	0.3221
0.1313	0.2616
0.1879	0.2618
0.1657	0.287
0.0642	0.0704
0.1973	0.3791
0.1265	0.1106
0.1461	0.3043
0.1319	0.299
0.2098	0.3706
0.0951	0.2086
0.2317	0.3786
0.1479	0.363
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
%exportgraphics(gcf, 'RMSEdis.png', 'Resolution', 300);
print(gcf, 'RMSEtde', '-dtiff', '-r300');

