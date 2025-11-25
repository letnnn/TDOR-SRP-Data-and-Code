function [timeDelay] = estimate_time_delay(audio1, audio2, fs)
    % estimate_time_delay - 使用GCC-PHAT方法估计两段音频信号的时延
    % 输入:
    %   audio1 - 第一段音频信号
    %   audio2 - 第二段音频信号
    %   fs - 采样率，单位为Hz
    % 输出:
    %   timeDelay - 估计的时延值，单位为秒
%音频1减音频2
    % Step 1: 计算两段音频信号的傅里叶变换
    X1 = fft(audio1);
    X2 = fft(audio2);
    
    % Step 2: 计算互功率谱并进行PHAT加权
    G12 = X1 .* conj(X2);        % 计算互功率谱
    G12_phat = G12 ./ abs(G12);  % 进行PHAT加权
    
    % Step 3: 计算加权后的互相关函数
    R12_phat = ifft(G12_phat);   % 反傅里叶变换到时域
    R12_phat = fftshift(R12_phat); % 将零频率分量移动到中心
    
    % Step 4: 找到互相关函数的峰值位置
    [~, maxIndex] = max(abs(R12_phat));  % 找到最大值位置
    
    % Step 5: 计算时延值
    N = length(audio1);  % 信号的长度
    delaySamples = maxIndex - N/2 - 1;  % 计算样本延迟
    timeDelay = delaySamples / fs;      % 将样本延迟转换为时间延迟（秒）
    
    % 输出估计的时延值
    fprintf('估计的时延值为 %.10f 秒\n', timeDelay);
end
