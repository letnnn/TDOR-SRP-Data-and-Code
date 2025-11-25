% 输入参数
time_delays = [  % 输入的三列时延差值（秒）
134	133.5576	130.9002
134	133.3964	130.9002
134	133.3968	130.9002
134	133.1846	130.9002
131	133.358	130.9002
132	133.2973	130.9002
135	133.3269	130.9002
134	133.1644	130.9002
134	133.2424	130.9002
134	133.3959	130.9002
135	133.4854	130.9002
131	133.1211	130.9002
132	133.1542	130.9002
135	133.242	130.9002
134	132.9452	130.9002
134	133.247	130.9002
133	133.5576	130.9002
135	133.5576	130.9002
133	133.0061	130.9002
132	133.2504	130.9002
];

reference = [133, 133, 133];  % 标准时延（秒）
%reference = [1.748,1.748];  % 标准时延（秒）

% Step 1: 差值矩阵
diff = time_delays - reference;

% Step 2: MSE
mse = mean(diff.^2);

% Step 3: RMSE
rmse = sqrt(mse);

% Step 4: MAE
mae = mean(abs(diff));

% Step 5: MAPE
mape = mean(abs(diff) ./ abs(reference)) * 100;

% Step 6: RMSPE
rmspe = sqrt(mean((abs(diff) ./ abs(reference)).^2)) * 100;

% Step 7: STD
std_dev = std(diff);

% Step 8: R² (相对误差定义)
r_squared_relative = zeros(1, size(diff, 2));
for i = 1:size(diff, 2)
    abs_diff = abs(diff(:, i));
    abs_reference_total = sum(abs(reference));
    r_squared_relative(i) = 1 - (sum(abs_diff) / abs_reference_total);
end

% 输出
%disp('每列 MSE：'); disp(mse);
disp('每列 RMSE：'); disp(rmse);
disp('每列 MAE：'); disp(mae);
disp('每列 MAPE：'); disp(mape);
%disp('每列 RMSPE：'); disp(rmspe);
%disp('每列 STD：'); disp(std_dev);
disp('每列 R^2 (相对误差定义)：'); disp(r_squared_relative);
