%% ================================
%   Azimuth / Elevation / Distance
%   RMSE, MAE, MAPE 计算脚本
%   可直接运行
% =================================

clc; clear; close all;

%% -------------------------------
% 1. 方位角数据（Azimuth）
% -------------------------------

az_GT = [
38.1
49.1
61.5
100.5
103
136
138.2
139.6
215
225.5
232
243.5
274.2
313
316.7
];

az_Pred = [
41.83
46.4
63
100.8
102.2
137.4
138.8
138.2
211.2
222.16
236.4
246.4
272.4
311
319.8
];

%% -------------------------------
% 2. 俯仰角数据（Elevation）
% -------------------------------

el_GT = [
32
37.6
21
59.5
25
36
30
16
38.5
29
43.6
50
52
49.5
23.5
];

el_Pred = [
30.66
38
23.16
64.2
28.6
36.4
29.6
17
42.6
30.66
39.6
55
59.4
55.83
26.6
];

%% -------------------------------
% 3. 距离数据（Distance）
% -------------------------------

dist_GT = [
2.67
2.29
1.68
1.74
1.44
2.15
2.37
2.39
2.40 
1.72
2.11
1.81
1.99
1.87
1.88
];

dist_Pred = [
2.88128
2.0413
1.932
1.764
1.38
2.18
2.1879
2.3932
2.1
1.96
2.3974
1.685
1.84568
1.614
1.8346
];

%% ============= 函数：误差指标计算 =============
calcRMSE = @(gt,pred) sqrt(mean((gt - pred).^2));
calcMAE  = @(gt,pred) mean(abs(gt - pred));
calcMAPE = @(gt,pred) mean(abs((gt - pred) ./ gt)) * 100;

%% ============= 计算三个指标 =============

% 方位角
az_RMSE = calcRMSE(az_GT, az_Pred);
az_MAE  = calcMAE(az_GT, az_Pred);
az_MAPE = calcMAPE(az_GT, az_Pred);

% 俯仰角
el_RMSE = calcRMSE(el_GT, el_Pred);
el_MAE  = calcMAE(el_GT, el_Pred);
el_MAPE = calcMAPE(el_GT, el_Pred);

% 距离
dist_RMSE = calcRMSE(dist_GT, dist_Pred);
dist_MAE  = calcMAE(dist_GT, dist_Pred);
dist_MAPE = calcMAPE(dist_GT, dist_Pred);

%% ============= 输出 =============
fprintf("===== 方位角 Azimuth =====\n");
fprintf("RMSE = %.4f\n", az_RMSE);
fprintf("MAE  = %.4f\n", az_MAE);
fprintf("MAPE = %.2f%%\n\n", az_MAPE);

fprintf("===== 俯仰角 Elevation =====\n");
fprintf("RMSE = %.4f\n", el_RMSE);
fprintf("MAE  = %.4f\n", el_MAE);
fprintf("MAPE = %.2f%%\n\n", el_MAPE);

fprintf("===== 距离 Distance =====\n");
fprintf("RMSE = %.4f\n", dist_RMSE);
fprintf("MAE  = %.4f\n", dist_MAE);
fprintf("MAPE = %.2f%%\n", dist_MAPE);
