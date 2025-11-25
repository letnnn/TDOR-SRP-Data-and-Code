

%% 柱状图：时延值计算图 MAPE
% 数据：GCC-PHAT (RMSE值)（交换两列数据）
GCC_PHAT = [
0.2338	5.7234
7.1734	1.0523
23.0812	11.6701
20.8027	27.2512
10.6897	27.5119
62.7334	15.0921
9.9394	11.27
5.4487	4.0962
6.2197	8.7147
11.5426	29.5528
17.9483	14.6028
9.5814	10.2312
42.1797	15.3456
41.825	15.3199
1.8371	3.2348
5.3824	0.7484
14.087	3.5947
1.2388	3.6906
12.5814	9.5775
44.6304	12.8901
10.2567	5.4729
43.9035	11.4489
67.8547	6.972
14.9944	5.1988
10.9297	7.7662
92.4166	15.0191
];

% 横坐标：1到26
x = 1:26;

% 创建图形窗口并调整大小
figure('Position', [100, 100, 1000, 400]); % 宽1000，高400，成长方形

% 绘制柱状图（按行分组，每个x有两根柱子），增加BarWidth参数
bar_handle = bar(x, GCC_PHAT, 'grouped', 'BarWidth', 1); % 调整柱子宽度

% 交换颜色，使得原始方法在前（蓝色），改进方法在后（红色）
bar_handle(1).FaceColor = [70/255, 130/255, 180/255];  % SteelBlue3 (GCC-PHAT)
bar_handle(2).FaceColor = [205/255, 79/255, 57/255];   % Tomato3 (Improved GCC-PHAT)

% 设置柱状图的轮廓颜色
bar_handle(1).EdgeColor = [0.8, 0.8, 0.8]; % 设置浅灰色轮廓
bar_handle(2).EdgeColor = [0.8, 0.8, 0.8]; % 设置浅灰色轮廓

% 设置图表标题和标签
title('MAPE', 'FontSize', 14, 'FontWeight', 'bold','FontName', 'Times New Roman');  % 设置标题字体大小
xlabel('Data(1-26)', 'FontSize', 12,'FontName', 'Times New Roman');  % 设置横坐标标签字体大小
ylabel('Distance Error(%)', 'FontSize', 12,'FontName', 'Times New Roman');  % 设置纵坐标标签字体大小

% 设置纵坐标范围 [0, 100]
ylim([0 100]);

% 设置横坐标范围 [1, 26]
xlim([0.5, 26.5]); % 避免边界数据被截断

% 设置 y 轴刻度
yticks(0:20:100); % 设置 y 轴从 0 到 100，间隔为 20

% 显示图例，并调整位置，设置字体大小
% 显示图例，并调整位置，设置字体大小
lgd = legend({'TDOA', 'TDOA-SRP'}, 'FontSize', 12,'FontName', 'Times New Roman');  % 先获取图例句柄
lgd.Location = 'northeast';  % 保持原位置
lgd.Units = 'normalized';    % 使用归一化单位
lgd.Position(1) = lgd.Position(1) - 0.015;  % 向左移动一点（例如减小 x 坐标）

% 添加网格，调整样式
grid on;
set(gca, 'GridLineStyle', '--', 'GridColor', [0.5, 0.5, 0.5]);

% 调整纵坐标刻度线的长度，使其变短
set(gca, 'TickLength', [0.004, 0.004]);

% 去除上侧和右侧的刻度
set(gca, 'Box', 'off');  % 去除坐标轴框
set(gca, 'TickDir', 'in');  % 刻度线朝向内侧

% 保存为高分辨率图片
%exportgraphics(gcf, 'MAPEdis.png', 'Resolution', 300);
print(gcf, 'MAPEdis', '-dtiff', '-r300');


%% 无
% % 数据：GCC-PHAT (RMSE值)
% GCC_PHAT = [
% 14.79	16.9
% 9.2	11.52
% 24.52	79.07
% 13.31	17.63
% 8.1	27.11
% 15.02	45.71
% 27.96	45.07
% 36.68	41.26
% 28.21	47.5
% 20.93	42.91
% 10.68	22.16
% 10.33	14.49
% 9.82	18.64
% 13.79	32.67
% 24	34.23
% 33.05	34.24
% 33.9	34.79
% 4.63	3.94
% 21.84	44.9
% 22.73	36.55
% 8.34	18.61
% 21.51	46.71
% 18.55	42.29
% 5.96	18.1
% 21.9	33.02
% 12.29	30.91
% ];
% 
% % 横坐标：1到26
% x = 1:26;
% 
% % 创建图形
% figure;
% 
% % 绘制第一列数据（圆圈标记，Tomato3 颜色线条）
% plot(x, GCC_PHAT(:,1), '-o', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [205/255, 79/255, 57/255]); % Tomato3 颜色
% 
% hold on;
% 
% % 绘制第二列数据（方形标记，SteelBlue3 颜色线条）
% plot(x, GCC_PHAT(:,2), '-s', 'LineWidth', 2, 'MarkerSize', 6, 'Color', [79/255, 148/255, 205/255]); % SteelBlue3 颜色
% 
% % 设置图表标题和标签
% title('MAPE', 'FontSize', 14, 'FontWeight', 'bold');
% xlabel('Data(1-26)', 'FontSize', 12); % 横坐标标签
% ylabel('', 'FontSize', 12); % 纵坐标标签
% 
% % 设置纵坐标范围 [0, 1]
% ylim([0 100]);
% 
% % 设置横坐标范围 [1, 26]
% xlim([1, 26]);
% 
% % 不显示图例（去掉图例部分）
% % legend('show', 'Location', 'northeast', 'FontSize', 12); 
% 
% % 添加网格，调整样式
% grid on;
% set(gca, 'GridLineStyle', '--', 'GridColor', [0.5, 0.5, 0.5]);
% 
% % 调整图形的边距
% set(gca, 'LooseInset', get(gca, 'TightInset'));
% 
% % 释放 hold
% hold off;
% 
% % 保存为高分辨率图片
% exportgraphics(gcf, 'GCC_PHAT_MAPE22.png', 'Resolution', 300);
