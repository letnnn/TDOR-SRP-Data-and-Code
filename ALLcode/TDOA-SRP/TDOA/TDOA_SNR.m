%% single_audio_SNR_test.m
clear; clc; close all;

%% ===== 基本参数 =====
c = 343;       % 声速 (m/s)
fs = 16000;    % 采样率 (Hz)

mic_positions = [
    -0.02150, +0.03725, +0;
    +0.02150, +0.03725, +0; 
    +0.02150, -0.03725, +0;
    -0.02150, -0.03725, +0
];

%% ==== 要测试的 SNR(dB)  ====
SNR_levels = [0, 10, 20, 30];

%% ===== 固定单组音频路径（修改这里即可） =====
base_path = 'Laboratory/实验1/1/';

audio1_file = fullfile(base_path, '音频 1-3.wav');
audio2_file = fullfile(base_path, '音频 1-4.wav');
audio3_file = fullfile(base_path, '音频 1-5.wav');
audio4_file = fullfile(base_path, '音频 1-6.wav');

%% ===== 读取音频 =====
try
    [audio1, fs] = audioread(audio1_file);
    [audio2, ~] = audioread(audio2_file);
    [audio3, ~] = audioread(audio3_file);
    [audio4, ~] = audioread(audio4_file);
catch
    error('❌ 无法读取音频文件，请检查路径');
end

original_audio = {audio1, audio2, audio3, audio4};

%% ===== 存储不同 SNR 的距离结果 =====
distances = NaN(length(SNR_levels),1);

%% ===== 遍历每个 SNR =====
for s = 1:length(SNR_levels)
    snr_value = SNR_levels(s);
    fprintf('\n======= 测试 SNR = %d dB =======\n', snr_value);

    % 添加噪声
    noisy_audio = cell(1,4);
    for k = 1:4
        noisy_audio{k} = awgn(original_audio{k}, snr_value, 'measured');
    end

    % 固定方向角（如需）
    azimuth_angle = 261;
    elevation_angle = 57;
    direction_vector = calculate_direction_vector(azimuth_angle, elevation_angle);

    %% ===== 时延估计 =====
    timeDelayMatrix = estimate_time_delay_matrix(noisy_audio, fs);

    %% ===== 声源定位 =====
    [~, distance] = calculate_locate_source(mic_positions, timeDelayMatrix, fs);

    distances(s) = distance;

    fprintf('SNR = %d dB → 距离: %.6f m\n', snr_value, distance);
end

%% ===== 输出最终结果 =====
fprintf('\n======== 所有 SNR 结果 ========\n');
T = table(SNR_levels', distances, 'VariableNames', {'SNR_dB', 'Distance_m'});
disp(T);

%% ===== 绘图 =====
figure;
plot(SNR_levels, distances, '-o', 'LineWidth', 1.6);
xlabel('SNR (dB)');
ylabel('Estimated Distance (m)');
title('Distance Estimation Under Different SNR');
grid on;
