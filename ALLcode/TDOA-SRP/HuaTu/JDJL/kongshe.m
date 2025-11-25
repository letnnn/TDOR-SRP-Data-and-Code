% 数据
labels = {'RMSE', 'MAE', 'MAPE (%)'};

azimuth = [2.6207, 2.32, 2.07];
elevation = [3.6843, 3.24, 9.04];
distance = [0.1855, 0.1544, 7.93];

% 横向柱状图数据格式：每一行是一个误差类型，每一列是一个指标
data = [azimuth; elevation; distance]';

% Y轴类别索引
y = 1:length(labels);

bar_width = 0.25;

figure;
hold on;

% 绘制3组横向柱状图，左右错开
barh(y - bar_width, azimuth, bar_width, 'FaceColor', [205/255, 79/255, 57/255], ...
    'EdgeColor', [0.7, 0.7, 0.7]);
barh(y, elevation, bar_width, 'FaceColor', [70/255, 130/255, 180/255], ...
    'EdgeColor', [0.7, 0.7, 0.7]);
barh(y + bar_width, distance, bar_width, 'FaceColor', [143/255, 188/255, 143/255], ...
    'EdgeColor', [0.7, 0.7, 0.7]);

hold off;

% 设置标签和刻度
set(gca, 'ytick', y, 'yticklabel', labels, 'FontName', 'Times New Roman', 'FontSize', 12);

xlabel('Error Value', 'FontName', 'Times New Roman', 'FontSize', 12);
ylabel('Error Type', 'FontName', 'Times New Roman', 'FontSize', 12);
title('Comparison of Errors by Dimension', 'FontName', 'Times New Roman', 'FontSize', 14, 'FontWeight', 'bold');

grid on;
ax = gca;
ax.GridLineStyle = '--';

% 调整刻度线长度
ax.XAxis.TickLength = [0.004, 0.004];
ax.YAxis.TickLength = [0.004, 0.004];

% 图例（顺序对应柱子颜色）
legend({'Azimuth', 'Elevation', 'Distance'}, 'FontName', 'Times New Roman', 'FontSize', 12, 'Location', 'bestoutside');

% 调整图像大小，减少空白
set(gcf, 'Position', [100, 100, 900, 450]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

% 保存图片（300 dpi TIFF格式）
print(gcf, 'Error_Comparison_HorizontalBar', '-dtiff', '-r300');
