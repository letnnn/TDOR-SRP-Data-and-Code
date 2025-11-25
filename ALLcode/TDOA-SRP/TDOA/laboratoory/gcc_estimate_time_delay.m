
% 方法一：gcc原始方法
function [timeDelay] = estimate_time_delay(audio1, audio2, fs)
%     estimate_time_delay_gcc - 使用标准GCC方法估计两段音频信号的时延
%     输入:
%       audio1, audio2 - 两段音频信号
%       fs - 采样率 (Hz)
%     输出:
%       timeDelay - 估计的时延值 (秒)
    
%     Step 1: 计算两段音频的傅里叶变换
    X1 = fft(audio1);
    X2 = fft(audio2);
    
%     Step 2: 计算互功率谱
    G12 = X1 .* conj(X2);
    
%     Step 3: 计算互相关函数（未加权）
    R12 = ifft(G12);
    R12 = fftshift(R12);
    
     %Step 4: 找到峰值位置
    [~, maxIndex] = max(abs(R12));
    
     %Step 5: 计算时延
    N = length(audio1);
    delaySamples = maxIndex - N/2 - 1;
    timeDelay = delaySamples / fs;
    
    fprintf('GCC估计的时延值为 %.10f 秒\n', timeDelay);
end