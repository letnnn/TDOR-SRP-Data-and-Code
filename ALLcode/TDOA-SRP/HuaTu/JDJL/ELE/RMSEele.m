%% 方位角误差对比柱状图
% 数据
data_azimuth = [
8.0062	8.2742	9.2287
6.0042	4.2531	9.1373
2.6	2.1167	8.0199
3.5143	17.0166	20.4089
2.4597	3.2632	6.7372
3.3	5.4081	6.4036
2	1.7978	3.2736
3	7.219	9.3498
1.118	3.1662	11.3932
3.9623	3.3096	5.6348
3.5637	5.3427	9.3371
2.8064	12.2157	2.2609
1.5811	2.7423	8.5911
5.4724	1.7628	9.7552
4.8836	1.7726	1.9801
4.3761	4.5074	0.9801
3.4713	5.2275	11.8526
0.8944	0.1798	2.4089
3	4.3995	2.831
2	3.2922	1.8604
1	3.991	8.5759
3.0578	2.5298	21.7561
1.5	4.7729	1.9336
2.9271	2.5624	3.3681
2.1909	5.2803	6.8521
3.0714	4.3636	6.7031
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
saveas(gcf, 'RMSE-ele.png');  
print(gcf, 'RMSE-ele', '-dtiff', '-r300');


%print(gcf, 'azimuth_angle_error_comparison_bar.pdf', '-dpdf', '-r300', '-bestfit');  % 使用 -bestfit 选项

