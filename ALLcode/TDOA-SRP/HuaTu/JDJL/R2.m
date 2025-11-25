%% 有名称框
% % 数据：GCC-PHAT (RMSE值)
% GCC_PHAT = [
% 0.5277	0.5249
% 0.702	0.6763
% 0.308	0.0065
% 0.5569	0.409
% 0.6929	0.2703
% 0.5741	0.1907
% 0.4669	0.2235
% 0.7648	0.5592
% 0.5528	0.2463
% 0.6705	0.3515
% 0.666	0.3158
% 0.7405	0.5336
% 0.6493	0.3913
% 0.8496	0.3588
% 0.6757	0.3511
% 0.5152	0.34
% 0.5748	0.3303
% 0.8779	0.8647
% 0.5139	0.1806
% 0.7056	0.7418
% 0.7071	0.3795
% 0.643	0.2725
% 0.5681	0.2878
% 0.8133	0.5857
% 0.4344	0.3135
% 0.8155	0.5442
% ];
% 
% % 横坐标：1到26
% x = 1:26;
% 
% % 创建图形
% figure;
% 
% % 绘制第一列数据（圆圈标记，Tomato3 颜色线条）并命名为改进GCC-PHAT
% plot(x, GCC_PHAT(:,1), '-o', 'DisplayName', 'Improved GCC-PHAT', ...
%     'LineWidth', 2, 'MarkerSize', 6, 'Color', [205/255, 79/255, 57/255]); % Tomato3 颜色
% 
% hold on;
% 
% % 绘制第二列数据（方形标记，SteelBlue3 颜色线条）并命名为GCC-PHAT
% plot(x, GCC_PHAT(:,2), '-s', 'DisplayName', 'GCC-PHAT', ...
%     'LineWidth', 2, 'MarkerSize', 6, 'Color', [79/255, 148/255, 205/255]); % SteelBlue3 颜色
% 
% % 设置图表标题和标签
% title('R²', 'FontSize', 12, 'FontWeight', 'bold');  % 设置标题字体大小
% xlabel('Data(1-26)', 'FontSize', 10);  % 设置横坐标标签字体大小
% ylabel('', 'FontSize', 10);  % 设置纵坐标标签字体大小
% 
% % 设置纵坐标范围 [0, 1]
% ylim([0 1]);
% 
% % 设置横坐标范围 [1, 26]
% xlim([1, 26]);
% 
% % 显示图例，并调整位置，设置字体大小
% legend('show', 'Location', 'northeast', 'FontSize', 10);  % 设置图例字体大小
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
% exportgraphics(gcf, 'GCC_PHAT_R².png', 'Resolution', 300);




%% 柱状图
% 数据：GCC-PHAT (R²值)
GCC_PHAT = [
    0.5277 0.5249;
    0.702 0.6763;
    0.308 0.0065;
    0.5569 0.409;
    0.6929 0.2703;
    0.5741 0.1907;
    0.4669 0.2235;
    0.7648 0.5592;
    0.5528 0.2463;
    0.6705 0.3515;
    0.666 0.3158;
    0.7405 0.5336;
    0.6493 0.3913;
    0.8496 0.3588;
    0.6757 0.3511;
    0.5152 0.34;
    0.5748 0.3303;
    0.8779 0.8647;
    0.5139 0.1806;
    0.7056 0.7418;
    0.7071 0.3795;
    0.643 0.2725;
    0.5681 0.2878;
    0.8133 0.5857;
    0.4344 0.3135;
    0.8155 0.5442;
];

% 交换数据的列，使得原始方法在前，改进方法在后
GCC_PHAT = GCC_PHAT(:, [2, 1]);

% 横坐标：1到26
x = 1:26;

% 创建图形窗口并调整大小
figure('Position', [100, 100, 1000, 400]); % 宽1000，高400，成长方形
set(gcf, 'DefaultTextFontName', 'Times New Roman'); % 设置默认文本字体

% 绘制柱状图（按行分组，每个x有两根柱子）
bar_handle = bar(x, GCC_PHAT, 'grouped', 'BarWidth', 1); % 调整柱子宽度

% 设置颜色（原始方法在前，改进方法在后）
bar_handle(1).FaceColor = [70/255, 130/255, 180/255];  % SteelBlue3 (GCC-PHAT)
bar_handle(2).FaceColor = [205/255, 79/255, 57/255];   % Tomato3 (Improved GCC-PHAT)

% 设置柱状图的轮廓颜色
bar_handle(1).EdgeColor = [0.8, 0.8, 0.8]; % 浅灰色轮廓
bar_handle(2).EdgeColor = [0.8, 0.8, 0.8]; % 浅灰色轮廓

% 设置图表标题和标签
title('R²', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');  
xlabel('Data(1-26)', 'FontSize', 12, 'FontName', 'Times New Roman');  
ylabel('', 'FontSize', 12, 'FontName', 'Times New Roman');  

% 设置纵坐标范围 [0, 1]
ylim([0 1]);

% 设置横坐标范围 [1, 26]
xlim([0.5, 26.5]); % 避免边界数据被截断

% 设置 y 轴刻度
yticks(0:0.2:1); % 设置 y 轴从 0 到 1，间隔为 0.2

% 显示图例，并调整位置，设置字体大小
legend({'GCC-PHAT', 'Improved GCC-PHAT'}, 'Location', 'northeast', 'FontSize', 12, 'FontName', 'Times New Roman');

% 设置坐标轴字体
set(gca, 'FontName', 'Times New Roman');

% 添加网格，调整样式
grid on;
set(gca, 'GridLineStyle', '--', 'GridColor', [0.5, 0.5, 0.5]);

% 调整纵坐标刻度线的长度，使其变短
set(gca, 'TickLength', [0.004, 0.004]);

% 去除上侧和右侧的刻度
set(gca, 'TickDir', 'in'); % 设置刻度线方向为外向
box off; % 去除框

% 保存为高分辨率图片
exportgraphics(gcf, 'GCC_PHAT_R²_bar.png', 'Resolution', 300);




%% 无名称框
% % 数据：GCC-PHAT (RMSE值)
% GCC_PHAT = [
% 0.5277	0.5249
% 0.702	0.6763
% 0.308	0.0065
% 0.5569	0.409
% 0.6929	0.2703
% 0.5741	0.1907
% 0.4669	0.2235
% 0.7648	0.5592
% 0.5528	0.2463
% 0.6705	0.3515
% 0.666	0.3158
% 0.7405	0.5336
% 0.6493	0.3913
% 0.8496	0.3588
% 0.6757	0.3511
% 0.5152	0.34
% 0.5748	0.3303
% 0.8779	0.8647
% 0.5139	0.1806
% 0.7056	0.7418
% 0.7071	0.3795
% 0.643	0.2725
% 0.5681	0.2878
% 0.8133	0.5857
% 0.4344	0.3135
% 0.8155	0.5442
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
% title('R²', 'FontSize', 12, 'FontWeight', 'bold');  % 设置标题字体大小
% xlabel('Data(1-26)', 'FontSize', 10);  % 设置横坐标标签字体大小
% ylabel('', 'FontSize', 10);  % 设置纵坐标标签字体大小
% 
% % 设置纵坐标范围 [0, 1]
% ylim([0 1]);
% 
% % 设置横坐标范围 [1, 26]
% xlim([1, 26]);
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
% exportgraphics(gcf, 'GCC_PHAT_R²22.png', 'Resolution', 300);
