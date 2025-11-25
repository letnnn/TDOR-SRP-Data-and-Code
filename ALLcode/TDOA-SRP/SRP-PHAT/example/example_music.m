% clc;clear;close all;
% %clc：清空命令窗口中的内容，相当于清屏。
% %clear：清空工作空间中的所有变量。
% %close all：关闭所有打开的图形窗口。
% disp('1')
% addpath(genpath('./../'));%将上一级目录（../）及其所有子目录添加到MATLAB的搜索路径中。genpath函数会递归地添加指定目录及其所有子目录。
% addpath('./wav files');%将当前目录下的名为"wav files"的子目录添加到MATLAB的搜索路径中。
% %% 设置文件及麦克风阵列位置
% fileName = 'a0e19_3_1b6ede00.wav';  
% micPos = ... 
% ...%  mic1	 mic2   mic3   mic4   mic5   mic6   mic7  mic8
%     [ -0.023  +0.023  +0.023  -0.023 ;  % x
%       -0.023  -0.023  +0.023  +0.023 ;  % y
%       +0.005    +0.005    +0.005    +0.005    ]; % z
% disp('15')
% azBound = [-180 180]; % 方位角范围设定
% elBound = [-90 90];   % 仰角范围设定（如果只有水平方向需要定位，elBound=0;
% gridRes = 1;          % 方位角/仰角的步长：gridRes 参数表示在方位角和仰角方向上的步长，即每隔多少度进行一次采样。
% alphaRes = 5;         % 步长设置alphaRes 则可能与波束成形算法中的某些参数有关，用于调节波束成形的性能
% 
% method = 'MUSIC';       %这是用于多传感器方向估计的一种常见方法，通过音频信号的协方差矩阵来估计信号的入射方向
% wlen = 512;             %定义了窗口长度，通常与信号进行傅立叶变换相关。
% window = hann(wlen);    %使用汉宁窗口对信号进行加窗处理，以减少频谱泄露和旁瓣干扰。
% noverlap = 0.5*wlen;    %窗口重叠的长度，通常设置为窗口长度的一半，以确保在进行傅立叶变换时有足够的重叠部分来保留频域信息。
% nfft = 512;             %傅立叶变换的点数，用于对信号进行频谱分析和频率成分提取。
% nsrc = 2;               % 源个数，需要定位的声源个数，用于多声源定位。
% c = 343;                % 声速
% freqRange = [];         % 计算的频率范围 []表示所有频率，如果为空，则表示对所有频率进行声源定位。
% pooling = 'max';        % 池化操作选择{'max' 'sum'}
% disp('30')
% %% 读取音频文件(fix)
% [x,fs] = audioread(fileName);       %用于读取音频文件，并将音频数据存储在 x 变量中，采样率存储在 fs 中。
% [nSample,nChannel] = size(x);       %通过 size(x) 函数获取音频数据 x 的维度，其中 nSample 表示样本数，nChannel 表示通道数。
% if nChannel>nSample, error('ERROR:输入数据样本 x 通道数'); end
% [~,nMic,~] = size(micPos);
% if nChannel~=nMic, error('ERROR:麦克风阵列与通道数不匹配'); end
% %% 存储参数(fix)
% Param = pre_paramInit(c,window, noverlap, nfft,pooling,azBound,elBound,gridRes,alphaRes,fs,freqRange,micPos);
% %% 定位(fix)
% if strfind(method,'SRP')
%     specGlobal = doa_srp(x,method, Param);
% elseif strfind(method,'SNR')
%     specGlobal = doa_mvdr(x,method,Param);
% elseif strfind(method,'MUSIC')
%     specGlobal = doa_music(x,Param,nsrc);
% else 
% end
% disp('48')
% %% 计算角度
% minAngle                   = 10;         % 查找时两个峰之间最小角度
% specDisplay                = 1;          % 是否显示角度图{1,0}
% [pfEstAngles,figHandle] = post_findPeaks(specGlobal, Param.azimuth, Param.elevation, Param.azimuthGrid, Param.elevationGrid, nsrc, minAngle, specDisplay);
% 
% azEst = pfEstAngles(:,1)';
% elEst = pfEstAngles(:,2)';
% for i = 1:nsrc
%     fprintf('第 %d 个源的位置为: \n Azimuth (Theta): %.0f \t Elevation (Phi): %.0f \n\n',i,azEst(i),elEst(i));
% end




%% =========================================
% 声源定位主程序（支持 SRP-PHAT / MUSIC / MVDR）
% 2025.09.03
%% =========================================
clc; clear; close all;

% =========================
% 添加路径
addpath(genpath('./../'));        % 上级目录及子目录
addpath('./wav files');           % 音频文件目录

% =========================
% 设置麦克风阵列位置
micPos = [ -0.02150  +0.02150  +0.02150  -0.02150 ;  
           +0.03725  +0.03725  -0.03725  -0.03725 ;  
           +0.0      +0.0      +0.0      +0.0    ]; 

% =========================
% 声源定位参数
azBound   = [-180 180];   % 方位角范围
elBound   = [0 90];       % 仰角范围
gridRes   = 1;            % 网格分辨率
alphaRes  = 5;            % 角度分辨率
method    = 'SRP-PHAT';   % 定位方法: 'SRP-PHAT', 'MUSIC', 'MVDR'
wlen      = 512;          % 窗口长度
window    = hann(wlen);   % 汉宁窗
noverlap  = 0.5*wlen;     % 窗口重叠
nfft      = 512;          % FFT 点数
nsrc      = 1;            % 声源数量
c         = 343;          % 声速 (m/s)
freqRange = [];           % 频率范围
pooling   = 'max';        % 池化方式

% =========================
% 循环处理音频
nExp = 40;  % 实验文件数量
azimuths   = nan(nExp, nsrc);  % 保存方位角
elevations = nan(nExp, nsrc);  % 保存仰角

startTime = tic;

for expNum = 1:nExp
    % 文件路径
    fileName = sprintf('KongShe/combine_70/%d_combined.wav', expNum);
    
    % =========================
    % 读取音频
    try
        [x, fs] = audioread(fileName);
    catch
        fprintf('无法读取文件: %d\n', expNum);
        continue;
    end
    
    [nSample, nChannel] = size(x);
    [~, nMic, ~] = size(micPos);
    if nChannel ~= nMic
        fprintf('文件 %d 的通道数与麦克风阵列不匹配\n', expNum);
        continue;
    end
    
    % =========================
    % 初始化参数
    Param = pre_paramInit(c, window, noverlap, nfft, pooling, ...
        azBound, elBound, gridRes, alphaRes, fs, freqRange, micPos);
    
    % =========================
    % 声源定位
    if contains(method,'SRP')
        specGlobal = doa_srp(x, method, Param);
    elseif contains(method,'SNR')
        specGlobal = doa_mvdr(x, method, Param);
    elseif contains(method,'MUSIC')
        specGlobal = doa_music(x, Param, nsrc);
    else
        error('未定义的定位方法');
    end
    
    % =========================
    % 提取峰值角度
    minAngle = 10;       % 峰值最小角度间隔
    specDisplay = 0;     % 不显示图
    [pfEstAngles, ~] = post_findPeaks(specGlobal, Param.azimuth, Param.elevation, ...
        Param.azimuthGrid, Param.elevationGrid, nsrc, minAngle, specDisplay);
    
    azEst = pfEstAngles(:,1)';
    elEst = pfEstAngles(:,2)';
    
    % =========================
    % 保存并输出结果
    for i = 1:nsrc
        if azEst(i) < 0
            azEst(i) = azEst(i) + 360;
        end
        azimuths(expNum,i)   = azEst(i);
        elevations(expNum,i) = elEst(i);
        fprintf('实验 %d - 第 %d 个源: Azimuth: %.0f, Elevation: %.0f\n', ...
            expNum, i, azEst(i), elEst(i));
    end
end

% =========================
% 输出总耗时
totalTime = toc(startTime);
fprintf('总共耗时: %.2f 秒\n', totalTime);

% =========================
% 保存结果到 CSV
resultTable = table((1:nExp)', azimuths, elevations, ...
    'VariableNames', {'Experiment', 'Azimuths', 'Elevations'});
outputFile = fullfile('./results', 'DOA_Results.csv');
if ~exist('./results', 'dir')
    mkdir('./results');
end
writetable(resultTable, outputFile);
fprintf('✅ 定位结果已保存: %s\n', outputFile);

