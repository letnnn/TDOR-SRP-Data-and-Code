% XMOS添加计时器---小论文中用的
% main_script.m
% 主程序 - 负责读取音频文件并调用各个功能模块

clear; clc; close all;

% 常量定义
c = 343;  % 声速（m/s）
fs = 16000;  % 采样频率（Hz）

% 麦克风的三维坐标 (x, y, z) 单位为米
mic_positions = [
    -0.02150, +0.03725, +0;
    +0.02150, +0.03725, +0; 
    +0.02150, -0.03725, +0;
    -0.02150, -0.03725, +0
];

% 要处理的实验文件编号
numFiles = 20;
distances = zeros(numFiles, 1);  % 存储每个文件的距离

% ===== 记录总运行时间 =====
total_tic = tic;

for experiment_number = 1:1      % 单组音频运行
    % ===== 记录单次运行时间 =====
    exp_tic = tic;

    % 构建文件路径
    audio1_file = sprintf('Laboratory/实验3/%d/音频 1-3.wav', experiment_number);
    audio2_file = sprintf('Laboratory/实验3/%d/音频 1-4.wav', experiment_number);
    audio3_file = sprintf('Laboratory/实验3/%d/音频 1-5.wav', experiment_number);
    audio4_file = sprintf('Laboratory/实验3/%d/音频 1-6.wav', experiment_number);

    % 尝试读取音频文件
    try
        [audio1, fs] = audioread(audio1_file);
        [audio2, ~]  = audioread(audio2_file);
        [audio3, ~]  = audioread(audio3_file);
        [audio4, ~]  = audioread(audio4_file);
    catch
        fprintf('无法读取文件: %d\n', experiment_number);
        distances(experiment_number) = NaN;
        continue;
    end

    %% 计算方向向量
    azimuth_angle = 261;    % 方位角
    elevation_angle = 57;   % 俯仰角
    direction_vector = calculate_direction_vector(azimuth_angle, elevation_angle);
    m = direction_vector(1);
    n = direction_vector(2);
    t = direction_vector(3);

    %% 计算时延
    audio_files = {audio1, audio2, audio3, audio4};
    timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);

    %% 声源定位（LM 算法）
    [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs, 'LM');

    %% 保存结果
    distances(experiment_number) = distance;

    % ===== ✔ 修正后的打印 =====
    fprintf('\n实验 %d 的声源位置: [%.4f, %.4f, %.4f]\n', ...
        experiment_number, sourceLocation(1), sourceLocation(2), sourceLocation(3));

    fprintf('声源到原点的距离: %.7f m\n', distance);

    % ===== 单次运行时间 =====
    exp_time = toc(exp_tic);
    fprintf('实验 %d 的运行时间: %.4f 秒\n', experiment_number, exp_time);
end

% ===== 输出所有文件的距离 =====
disp('======= 所有文件的距离 =======');
disp(distances);

% ===== 输出总运行时间 =====
total_time = toc(total_tic);
fprintf('\n总运行时间: %.4f 秒\n', total_time);
