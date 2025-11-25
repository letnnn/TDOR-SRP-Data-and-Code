function [specGlobal] = doa_mvdr(x, method, Param)
% 此函数使用MVDR算法或其变体计算到达方向（DOA）。
% 输入:
%   x: 输入信号
%   method: 计算DOA的方法，选项为 'SNR-MVDR', 'SNR-FWMVDR', 'SNR-DS', 'SNR-FWDS'
%   Param: 算法参数
% 输出:
%   specGlobal: 全局谱密度估计
% 检查 Param.freqBins 的合法性
if (~any(strcmp(method, {'SNR-MVDR' 'SNR-FWMVDR' 'SNR-DS' 'SNR-FWDS'})))
    error('错误：无效的方法参数');   
end

lf = 8;
lt = 2;
Rxx = ssl_Rxx(x, Param.fs, Param.window, Param.noverlap, Param.nfft, lf, lt);
Rxx = permute(Rxx(:,:,2:end,:),[3 4 1 2]); % nbin x nFrames x nChan x nChan
disp('size(Rxx)');
disp(size(Rxx));
%这两段代码的结果是计算信号的自相关矩阵 Rxx，并对其进行维度排列
if strcmp(method,'SNR-MVDR')
    Param.freqBins = max(1, min(Param.freqBins, size(Rxx, 1)));
%    disp(Param.freqBins);
    specGlobal = ssl_MVDR(Rxx, Param);
elseif strcmp(method,'SNR-FWMVDR')
    Param.freqBins = max(1, min(Param.freqBins, size(Rxx, 1)));
    specGlobal = ssl_FWMVDR(Rxx, Param);
elseif strcmp(method,'SNR-DS')
    Param.freqBins = max(1, min(Param.freqBins, size(Rxx, 1)));
    specGlobal = ssl_DS(Rxx, Param);
elseif strcmp(method,'SNR-FWDS')
    Param.freqBins = max(1, min(Param.freqBins, size(Rxx, 1)));
    specGlobal = ssl_FWDS(Rxx, Param);
else
    error('错误：无效的方法');
end
end


function [hatRxx] = ssl_Rxx(x, fs, window, noverlap, nfft, lf, lt)
% SSL_RXX 计算信号的短时自相关矩阵
%   hatRxx = SSL_RXX(x, fs, window, noverlap, nfft, lf, lt) 返回信号 x 的短时自相关矩阵
%
%   输入参数:
%       x: 输入信号
%       fs: 采样率
%       window: 窗口类型
%       noverlap: 重叠量
%       nfft: FFT长度
%       lf: 频率方向窗口长度
%       lt: 时间方向窗口长度
%
%   输出参数:
%       hatRxx: 计算得到的短时自相关矩阵
% 检查输入参数
if nargin < 3
    error('Not enough input arguments.');
end
[nsampl, nchan] = size(x);
if nchan > nsampl
    error('The input signal must be in columns.');
end
if nargin < 4
    lf = 2;
end
if nargin < 5
    lt = 2;
end
% 计算输入信号的短时傅立叶变换
X = ssl_stft(x.', window, noverlap, nfft, fs);
X = X(2:end, :, :);
[nbin, nfram, nchan] = size(X);
% 初始化频率方向和时间方向的汉宁窗口
winf = hanning(2 * lf - 1);
wint = hanning(2 * lt - 1).';
% 初始化短时自相关矩阵
hatRxx = zeros(nchan, nchan, nbin, nfram);
% 生成所有可能的信道配对
pairId = nchoosek(1:nchan, 2);
[nPairs, ~] = size(pairId);
% 循环遍历频率和时间帧
for f = 1:nbin
    for t = 1:nfram
        % 确定当前局部计算的频率和时间帧范围
        indf = max(1, f - lf + 1):min(nbin, f + lf - 1);
        indt = max(1, t - lt + 1):min(nfram, t + lt - 1);
        nind = length(indf) * length(indt);
        wei = ones(nchan, 1) * reshape(winf(indf - f + lf) * wint(indt - t + lt), 1, nind);
        % 提取局部信号并计算局部自相关矩阵
        XX = reshape(X(indf, indt, :), nind, nchan).';
        local_Cx = (XX .* wei) * XX' / sum(wei(1, :));
        % 循环遍历信道配对
        for idPair = 1:nPairs
            % 将局部自相关矩阵的对角线元素填入 hatRxx 中相应位置
            hatRxx(pairId(idPair, :), pairId(idPair, :), f, t) = local_Cx(pairId(idPair, :), pairId(idPair, :));
        end
    end
end
end

function [specGlobal] = ssl_DS(hatRxx,Param)
[~,nFrames,~,~] = size(hatRxx); % nbin x nFrames x 2 x 2
specInst = zeros(Param.nGrid, nFrames);

for i = 1:Param.nPairs
    spec = ds_spec(hatRxx(Param.freqBins,:,Param.pairId(i,:),Param.pairId(i,:)), Param.f(Param.freqBins), Param.tauGrid{i}); %
    specSampledgrid = (shiftdim(sum(spec,1)))';
    specCurrentPair = interp1q(Param.alphaSampled{i}', specSampledgrid, Param.alpha(i,:)');
    specInst = specInst + specCurrentPair;
end

switch Param.pooling
    case 'max'
        specGlobal = shiftdim(max(specInst,[],2));
    case 'sum'
        specGlobal = shiftdim(sum(specInst,2));
end
end
function [specGlobal] = ssl_FWDS(hatRxx, Param)

[~,nFrames,~,~] = size(hatRxx); % nbin x nFrames x 2 x 2
specInst = zeros(Param.nGrid, nFrames);

for i = 1:Param.nPairs
    spec = fwDs_spec(hatRxx(Param.freqBins,:,Param.pairId(i,:),Param.pairId(i,:)), Param.f(Param.freqBins), Param.d(i), Param.tauGrid{i},Param.c); %
    specSampledgrid = (shiftdim(sum(spec,1)))';
    specCurrentPair = interp1q(Param.alphaSampled{i}', specSampledgrid, Param.alpha(i,:)');
    specInst = specInst + specCurrentPair;
end

switch Param.pooling
    case 'max'
        specGlobal = shiftdim(max(specInst,[],2));
    case 'sum'
        specGlobal = shiftdim(sum(specInst,2));
end
end
function [specGlobal] = ssl_MVDR(hatRxx,Param)
[~,nFrames,~,~] = size(hatRxx); % nbin x nFrames x nmic x nmic
specInst = zeros(Param.nGrid, nFrames);
% 检查 Param.freqBins 的合法性
if any(Param.freqBins < 1) || any(Param.freqBins > size(hatRxx, 1))
    error('Param.freqBins 超出了合理范围');
end
for i = 1:Param.nPairs
    % 检查 Param.pairId(i,:) 的合法性
    if any(Param.pairId(i,:) < 1) || any(Param.pairId(i,:) > size(hatRxx, 3))
        error(['Param.pairId(', num2str(i), ':) 超出了合理范围']);
    end
    spec = mvdr_spec(hatRxx(Param.freqBins,:,Param.pairId(i,:),Param.pairId(i,:)), Param.f(Param.freqBins), Param.tauGrid{i}); % 鍙栦竴瀵归害鍏嬮杩涜MVDR
    specSampledgrid = (shiftdim(sum(spec,1)))'; % sum on frequencies
    specCurrentPair = interp1q(Param.alphaSampled{i}', specSampledgrid, Param.alpha(i,:)');
    specInst = specInst + specCurrentPair;
end

switch Param.pooling
    case 'max'
        specGlobal = shiftdim(max(specInst,[],2));
    case 'sum'
        specGlobal = shiftdim(sum(specInst,2));
end
end
function [specGlobal] = ssl_FWMVDR(hatRxx,Param)

[~,nFrames,~,~] = size(hatRxx); % nbin x nFrames x 2 x 2
specInst = zeros(Param.nGrid, nFrames);

for i = 1:Param.nPairs
    spec = fwMvdr_spec(hatRxx(Param.freqBins,:,Param.pairId(i,:),Param.pairId(i,:)), Param.f(Param.freqBins), Param.d(i), Param.tauGrid{i}, Param.c); %
    specSampledgrid = (shiftdim(sum(spec,1)))';
    specCurrentPair = interp1q(Param.alphaSampled{i}', specSampledgrid, Param.alpha(i,:)');
    specInst = specInst + specCurrentPair;
end

switch Param.pooling
    case 'max'
        specGlobal = shiftdim(max(specInst,[],2));
    case 'sum'
        specGlobal = shiftdim(sum(specInst,2));
end
end
function X=ssl_stft(x,window,noverlap,nfft,fs)

% Inputs:x: nchan x nsampl  window = blackman(wlen);
% Output:X: nbin x nfram x nchan matrix 

[nchan,~]=size(x);
[Xtemp,F,T,~] = spectrogram(x(1,:),window,noverlap,nfft,fs); % S nbin x nframe
nbin = length(F);
nframe = length(T);
X = zeros(nbin,nframe,nchan);
X(:,:,1) = Xtemp;
for ichan = 2:nchan
    X(:,:,ichan) = spectrogram(x(ichan,:),window,noverlap,nfft,fs); 
end

end