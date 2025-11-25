% XMOS添加计时器---小论文中用的
% main_script_single_group.m
% 只运行一组音频

clear; clc; close all;

% 常量定义
c = 343;      % 声速（m/s）
fs = 16000;   % 采样频率（Hz）

% 麦克风坐标 (x, y, z)
mic_positions = [
    -0.02150, +0.03725, +0;
    +0.02150, +0.03725, +0; 
    +0.02150, -0.03725, +0;
    -0.02150, -0.03725, +0
];

% ===== 计时 =====
total_tic = tic;

% 指定要运行的实验编号
experiment_number = 1;

% 构建音频文件路径
audio1_file = sprintf('Laboratory/实验1/%d/音频 1-3.wav', experiment_number);
audio2_file = sprintf('Laboratory/实验1/%d/音频 1-4.wav', experiment_number);
audio3_file = sprintf('Laboratory/实验1/%d/音频 1-5.wav', experiment_number);
audio4_file = sprintf('Laboratory/实验1/%d/音频 1-6.wav', experiment_number);

% 尝试读取音频文件
try
    [audio1, fs] = audioread(audio1_file);
    [audio2, fs] = audioread(audio2_file);
    [audio3, fs] = audioread(audio3_file);
    [audio4, fs] = audioread(audio4_file);
catch
    error('无法读取音频文件，请检查路径！');
end

%% 计算方向向量
azimuth_angle = 261;    % 方位角
elevation_angle = 57;   % 俯仰角
direction_vector = calculate_direction_vector(azimuth_angle, elevation_angle);
m = direction_vector(1);
n = direction_vector(2);
t = direction_vector(3);

%% 计算时延矩阵
audio_files = {audio1, audio2, audio3, audio4};
timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);

%% 声源定位（示例使用 DE）
[sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs, 'DE');

%% 输出结果
fprintf('\n【单组音频运行结果】\n');
fprintf('实验 %d 声源位置: [%.4f, %.4f, %.4f]\n', experiment_number, sourceLocation);
fprintf('声源到原点距离: %.7f m\n', distance);

%% 总运行时间
total_time = toc(total_tic);
fprintf('总运行时间: %.4f 秒\n', total_time);
