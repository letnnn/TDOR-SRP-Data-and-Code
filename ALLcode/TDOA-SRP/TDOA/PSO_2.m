%% 单组音频运行（无循环）
clc; clear; close all;

%% 常量定义
c = 343;            % 声速
fs = 16000;         % 采样率

%% 麦克风三维位置 (m)
mic_positions = [
    -0.02150, +0.03725, +0.00;
    +0.02150, +0.03725, +0.00; 
    +0.02150, -0.03725, +0.00;
    -0.02150, -0.03725, +0.00
];

%% ======= 选择要运行的实验号（手动修改这一行即可） =======
experiment_number = 1;
% ===============================================================

%% 构建文件路径（与你原代码一致）
audio1_file = sprintf('空舍实验/实验23/%d/音频 1-3.wav', experiment_number);
audio2_file = sprintf('空舍实验/实验23/%d/音频 1-4.wav', experiment_number);
audio3_file = sprintf('空舍实验/实验23/%d/音频 1-5.wav', experiment_number);
audio4_file = sprintf('空舍实验/实验23/%d/音频 1-6.wav', experiment_number);

%% 尝试读取音频
try
    [audio1, fs] = audioread(audio1_file);
    [audio2, fs] = audioread(audio2_file);
    [audio3, fs] = audioread(audio3_file);
    [audio4, fs] = audioread(audio4_file);
catch
    fprintf('无法读取文件 %d\n', experiment_number);
    return;     % 直接退出，无循环
end

%% ====== 方向角（你后续会改成真实角度）======
azimuth_angle = 261;
elevation_angle = 57;
direction_vector = calculate_direction_vector(azimuth_angle, elevation_angle);
m = direction_vector(1);
n = direction_vector(2);
t = direction_vector(3);

%% ====== 时延计算 ======
audio_files = {audio1, audio2, audio3, audio4};
timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);

%% ====== 声源定位 ======
[sourceLocation, distance, alpha_deg, elevation_deg] = ...
    calculate_locate_source(mic_positions, timeDelayMatrix, fs);

%% 输出结果
disp('====================================');
disp(['实验 ', num2str(experiment_number), ' 的声源定位结果']);
disp('------------------------------------');
disp(['声源位置： ', mat2str(sourceLocation, 6)]);
disp(['距离 (m)： ', num2str(distance)]);
disp(['方位角 Azimuth (°)： ', num2str(alpha_deg)]);
disp(['俯仰角 Elevation (°)： ', num2str(elevation_deg)]);
disp('====================================');
