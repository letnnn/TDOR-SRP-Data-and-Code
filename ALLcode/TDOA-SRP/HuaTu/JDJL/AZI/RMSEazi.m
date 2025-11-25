%% 方位角误差对比柱状图
% 数据
data_azimuth = [
1	2.6554	4.8369
2.1448	0.7678	2.0789
0.866	11	16.0076
1.0488	3.0898	2.0998
2.0857	1.3167	4.1223
3.3985	3.8423	13.753
2.9411	7.7861	18.1701
4.2953	4.3625	4.5873
5	3.6905	12.3497
1.6882	4.2779	5.2309
3.1145	4.6721	9.3795
1.3038	0.5846	0.9044
1.3416	6.9109	2.0998
1.533	1.1651	3.942
1.7029	0.3878	0.0076
0	1.0208	0.0076
1.6733	2.1381	1.0075
1.7464	1.02	0.9002
4.4328	3	13.787
5	2	6
3.25	3.5	5.4474
1.9621	1.545	2.4418
1.9235	1.334	9.8087
0.6787	1.6583	8.9002
3.2249	6.3249	12.0074
1.7728	2.4155	4.4845
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
ylabel('Angular Error(°)', 'FontName', 'Times New Roman', 'FontSize', 12);


% 标题
%title('RMSE', 'FontName', 'Times New Roman', 'FontSize', 12);
title('RMSE', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% 设置横坐标刻度
xticks(1:26);

% 调整纵坐标的刻度线长度
ax.XAxis.TickLength = [0.004, 0.004];  % 横坐标刻度线长度
ax.YAxis.TickLength = [0.004, 0.004];  % 纵坐标刻度线长度

% 设置纵坐标范围为0到25，步长为5
ylim([0 25]);
yticks(0:5:25);

% 图例
legend('TDOA', 'Improved TDOA', 'TDOA-SRP', 'FontName', 'Times New Roman', 'FontSize', 12);

% 调整图像大小，减少两边空白
set(gcf, 'Position', [100, 100, 1500, 600]);  % 减少宽度以减少空白
set(gca, 'LooseInset', get(gca, 'TightInset')); % 去除空白区域

% 保存为高质量图片
%saveas(gcf, 'RMSE-AZI.png');
print(gcf, 'RMSE-AZI', '-dtiff', '-r300');

%print(gcf, 'azimuth_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项

