%% 方位角误差对比柱状图
% 数据
data_azimuth = [
7.9	8.2216	7.192
5	4.0269	8.8619
2.45	2.0526	8.0199
2.65	16.9881	20.4089
2	3.2592	6.7372
3	5.3912	6.3754
1.9	1.6432	2.1382
2.5	7.1903	9.3498
1.05	3.1617	7.5134
3.5	3.3035	5.5992
2.9	5.2271	8.5639
2.6348	7.2593	2.2609
1.2	2.7384	8.5911
4.8947	1.4518	9.7552
3.85	1.6756	1.9801
4.35	4.494	0.9801
3.05	5.2038	11.8526
0.7	0.141	2.4089
3	4.3947	2.8139
2	3.2916	1.8604
0.5	3.9877	8.1571
3.05	2.5213	12.8773
1.5	4.7632	1.8914
2.4838	2.5574	3.3681
2	5.2788	6.8521
3	4.3534	4.4274
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
%saveas(gcf, 'MAEele.png');  
print(gcf, 'MAEele', '-dtiff', '-r300');

%print(gcf, 'azimuth_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项

