%% 单文件运行版本（无循环）
clc; clear; close all;

% 添加路径
addpath(genpath('./../'));
addpath('./wav files');

%% 设置麦克风阵列位置
micPos = [ -0.02150  +0.02150  +0.02150  -0.02150 ;  
           +0.03725  +0.03725  -0.03725  -0.03725 ;  
           +0.0      +0.0      +0.0      +0.0    ];

%% 参数设置
azBound = [-180 180];
elBound = [0 90];
gridRes   = 1;
alphaRes  = 5;
method    = 'SRP-PHAT';
wlen      = 512;
window    = hann(wlen);
noverlap  = 0.5 * wlen;
nfft      = 512;
nsrc      = 1;
c         = 343;
freqRange = [];
pooling   = 'max';

%% ======== 选择要运行的音频文件 ========
experiment_number = 1;   % ← 只需要改这里！
fileName = sprintf('KongShe/combine_23/%d_combined.wav', experiment_number);

%% 读取音频
try
    [x, fs] = audioread(fileName);
catch
    error('无法读取文件: %s', fileName);
end

[nSample, nChannel] = size(x);
[~, nMic, ~] = size(micPos);

if nChannel ~= nMic
    error('ERROR：音频通道数与麦克风数量不匹配');
end

%% 初始化参数
Param = pre_paramInit(c, window, noverlap, nfft, pooling, ...
                      azBound, elBound, gridRes, alphaRes, fs, freqRange, micPos);

%% 执行 SRP-PHAT 定位
if contains(method, 'SRP')
    specGlobal = doa_srp(x, method, Param);
elseif contains(method, 'SNR')
    specGlobal = doa_mvdr(x, method, Param);
elseif contains(method, 'MUSIC')
    specGlobal = doa_music(x, Param, nsrc);
end

%% 计算角度
minAngle = 10;
specDisplay = 0;

[pfEstAngles, ~] = post_findPeaks(specGlobal, Param.azimuth, Param.elevation, ...
                                  Param.azimuthGrid, Param.elevationGrid, ...
                                  nsrc, minAngle, specDisplay);

azEst = pfEstAngles(1,1);
elEst = pfEstAngles(1,2);

%% 角度修正
if azEst < 0
    azEst = azEst + 360;
end

%% 输出最终结果
fprintf("====== 单文件运行结果 ======\n");
fprintf("文件: %s\n", fileName);
fprintf("Azimuth (°): %.2f\n", azEst);
fprintf("Elevation (°): %.2f\n", elEst);
fprintf("============================\n");
