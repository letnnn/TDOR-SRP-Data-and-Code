% === 真值与测量结果 ===
true_dist = 44;   % 标准距离（m）



predicted_dist = [
45
44
48
45
47
45
45
48
45
45
45
45
45
45
45
47
45
45
41
47
];
      
              % === 误差计算 ===
RMSE = sqrt(mean((predicted_dist - true_dist).^2));
MAE  = mean(abs(predicted_dist - true_dist));
MAPE = mean(abs((predicted_dist - true_dist) / true_dist)) * 100;

% === 输出结果（表格形式）===
fprintf('RMSE\tMAE\tMAPE\n');
fprintf('%.6f\t%.6f\t%.3f\n', RMSE, MAE, MAPE);
