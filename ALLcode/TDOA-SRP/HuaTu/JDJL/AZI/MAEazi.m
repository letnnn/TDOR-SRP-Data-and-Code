%% 方位角误差对比柱状图
% 数据
data_azimuth = [
1	2.6467	4.5977
2	0.5995	1.6964
0.35	11	16.0076
0.8	3.0441	2.0998
1.55	1.2725	4.1223
3.15	3.7984	13.6294
2.45	7.6674	17.8758
4.05	4.358	4.5873
5	3.6801	10.4938
1.05	4.2394	5.2098
2.5	4.6042	8.3975
1.2	0.3209	0.9044
1	2.4275	2.0998
1.05	1.1146	3.942
0.7	0.3117	0.0076
0	1.0193	0.0076
1.4	2.1293	1.0075
1.45	1.0112	0.9002
4.15	3	12.8676
5	2	6
3.25	3.5	2.7237
1.95	1.5013	1.9581
1.5	1.1844	9.3461
0.6116	1.35	8.9002
3.1	6.3231	12.0074
1.4286	2.4005	4.1601
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
title('MAE', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

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
%saveas(gcf, 'MAEazi.png');  
print(gcf, 'MAEazi', '-dtiff', '-r300');

%print(gcf, 'azimuth_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项

