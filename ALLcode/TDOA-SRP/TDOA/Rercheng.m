% main_script.m
% 主程序 - 负责读取音频文件并调用各个功能模块

% 常量定义
c = 343;  % 声速（m/s）
fs = 16000;  % 采样频率（Hz）

% 麦克风的三维坐标 (x, y, z) 单位为米
mic_positions = [
    -0.02150, +0.03725, +0.0;
    +0.02150, +0.03725, +0.0; 
    +0.02150, -0.03725, +0.0;
    -0.02150, -0.03725, +0.0
];


[audio1, fs] = audioread('第一次实验记录/5/11/音频 1-3.wav');
[audio2, fs] = audioread('第一次实验记录/5/11/音频 1-4.wav');
[audio3, fs] = audioread('第一次实验记录/5/11/音频 1-5.wav');
[audio4, fs] = audioread('第一次实验记录/5/11/音频 1-6.wav');
%% 计算时延

audio_files = {audio1, audio2, audio3, audio4};
fs = 16000;  % 采样频率

% 调用函数，计算时延矩阵
timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);

% 输出时延矩阵
 disp('时延矩阵 (保留8位小数):');
 disp(timeDelayMatrix);


% distance = calculate_r(mic_positions, timeDelayMatrix, fs);



