%% 柱状图

% 数据：GCC-PHAT (RMSE值)
GCC_PHAT = [
 0.1763	0.0072
0.035	0.2387
0.2731	0.5401
0.696	0.5313
0.6463	0.2511
0.2344	0.9742
0.2567	0.2264
0.0831	0.1105
0.1839	0.1312
0.5346	0.2088
0.3557	0.4372
0.2884	0.2701
0.333	0.9153
0.3467	0.9465
0.0949	0.0539
0.0205	0.1471
0.1	0.392
0.1153	0.0387
0.1904	0.2501
0.218	0.7547
0.1524	0.2857
0.2219	0.8509
0.1618	1.5742
0.1395	0.4023
0.1712	0.241
0.2625	1.6154
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
%exportgraphics(gcf, 'MAEdis.png', 'Resolution', 300);
print(gcf, 'MAEdis', '-dtiff', '-r300');
