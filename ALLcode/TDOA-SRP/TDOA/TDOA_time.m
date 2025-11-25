
%% main_script_single_timing.m
% 单次实验音频处理程序（详细分段计时版）

clear; clc; close all;

% ===== 常量定义 =====
c = 343;      % 声速（m/s）
fs = 16000;   % 采样频率（Hz）

% 麦克风三维坐标 (x, y, z) 单位为米
mic_positions = [
    -0.02150, +0.03725, +0;
    +0.02150, +0.03725, +0; 
    +0.02150, -0.03725, +0;
    -0.02150, -0.03725, +0
];

% 设置实验编号
experiment_number = 1;

% ===== 总计时 =====
total_tic = tic;

%% ===== 1. 音频读取 =====
read_tic = tic;
try
    audio1_file = sprintf('Laboratory/实验10/%d/音频 1-3.wav', experiment_number);
    audio2_file = sprintf('Laboratory/实验10/%d/音频 1-4.wav', experiment_number);
    audio3_file = sprintf('Laboratory/实验10/%d/音频 1-5.wav', experiment_number);
    audio4_file = sprintf('Laboratory/实验10/%d/音频 1-6.wav', experiment_number);

    [audio1, fs] = audioread(audio1_file);
    [audio2, fs] = audioread(audio2_file);
    [audio3, fs] = audioread(audio3_file);
    [audio4, fs] = audioread(audio4_file);
catch
    error('无法读取实验 %d 的音频文件。', experiment_number);
end
read_time = toc(read_tic);
fprintf('实验 %d 音频读取时间: %.4f 秒\n', experiment_number, read_time);

audio_files = {audio1, audio2, audio3, audio4};

%% ===== 2. 时延计算 =====
td_tic = tic;
timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);
td_time = toc(td_tic);
fprintf('实验 %d 时延计算时间: %.4f 秒\n', experiment_number, td_time);

%% ===== 3. 声源定位 =====
loc_tic = tic;
[sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs);
% 若想改用其他求解器，可用以下任意一行：
%[sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs, 'LM');
%[sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs, 'NM');
%[sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs, 'DE');
%[sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs, 'SA');
loc_time = toc(loc_tic);
fprintf('实验 %d 声源定位时间: %.4f 秒\n', experiment_number, loc_time);

%% ===== 4. 总计时与其他开销 =====
total_time = toc(total_tic);
other_time = total_time - (read_time + td_time + loc_time);
fprintf('实验 %d 其他开销时间: %.4f 秒\n', experiment_number, other_time);

%% ===== 5. 输出结果 =====
fprintf('\n实验 %d 的声源位置: [%.4f, %.4f, %.4f]\n', experiment_number, sourceLocation);
fprintf('声源到原点的距离: %.7f m\n', distance);
fprintf('实验 %d 总运行时间: %.4f 秒\n', experiment_number, total_time);

