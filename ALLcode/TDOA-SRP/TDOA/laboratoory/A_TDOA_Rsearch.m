% % main_script.m
% % 主程序 - 负责读取音频文件并调用各个功能模块
% 
% % 常量定义
% c = 343;  % 声速（m/s）
% fs = 16000;  % 采样频率（Hz）
% 
% % 麦克风的三维坐标 (x, y, z) 单位为米
% mic_positions = [
%     -0.02150, +0.03725, +0;
%     +0.02150, +0.03725, +0; 
%     +0.02150, -0.03725, +0;
%     -0.02150, -0.03725, +0
% ];
% 
% %% 要改的数据
% % % 定义实验记录的编号
% % experiment_number = 3;  % 更改这个值来处理不同的实验记录
% % % 构建文件路径
% % audio1_file = sprintf('第一次实验记录/%d/12/音频 1-3.wav', experiment_number);
% % audio2_file = sprintf('第一次实验记录/%d/12/音频 1-4.wav', experiment_number);
% % audio3_file = sprintf('第一次实验记录/%d/12/音频 1-5.wav', experiment_number);
% % audio4_file = sprintf('第一次实验记录/%d/12/音频 1-6.wav', experiment_number);
% [audio1, fs] = audioread('第三次试验记录 22/2/6/音频 1-3.wav');
% [audio2, fs] = audioread('第三次试验记录 22/2/6/音频 1-4.wav');
% [audio3, fs] = audioread('第三次试验记录 22/2/6/音频 1-5.wav');
% [audio4, fs] = audioread('第三次试验记录 22/2/6/音频 1-6.wav');
% 
% %% 计算时延
% 
% %221	63
% % 假设 audio1, audio2, audio3, audio4 是四个麦克风的音频数据
% audio_files = {audio1, audio2, audio3, audio4};
% fs = 16000;  % 采样频率
% 
% % 调用函数，计算时延矩阵
% timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);
% 
% % 输出时延矩阵
% disp('时延矩阵 (保留8位小数):');
% disp(timeDelayMatrix);
% 
% %% 定位
% c = 343;  % 声速 (m/s)
% gridStep = 0.05;  % 网格步长 (m)
% 
% % 调用函数
% [bestLocation, distanceToOrigin, Jp] = calculate_search_locate_source(mic_positions, timeDelayMatrix, c, gridStep);
% 
% % 输出结果
% fprintf('最佳声源位置: (%.8f, %.8f, %.8f)\n', bestLocation(1), bestLocation(2), bestLocation(3));
% fprintf('最佳位置到原点的距离: %.8f\n', distanceToOrigin);
% 
% 


%%  xmos
% % main_script.m
% % 主程序 - 负责读取音频文件并调用各个功能模块
% 
% % 常量定义
% c = 343;  % 声速（m/s）
% % fs = 16000;  % 采样频率（Hz）
% 
% % 麦克风的三维坐标 (x, y, z) 单位为米
% mic_positions = [
%     -0.02150, +0.03725, +0;
%     +0.02150, +0.03725, +0; 
%     +0.02150, -0.03725, +0;
%     -0.02150, -0.03725, +0
% ];
% 
% % 要处理的实验文件编号
% numFiles = 40;  % 假设有40个文件
% distances = zeros(numFiles, 1);  % 存储每个文件的距离
% 
% for experiment_number = 1:numFiles
%     % 构建文件路径
%     audio1_file = sprintf('第三次试验记录 22/2/%d/音频 1-3.wav', experiment_number);
%     audio2_file = sprintf('第三次试验记录 22/2/%d/音频 1-4.wav', experiment_number);
%     audio3_file = sprintf('第三次试验记录 22/2/%d/音频 1-5.wav', experiment_number);
%     audio4_file = sprintf('第三次试验记录 22/2/%d/音频 1-6.wav', experiment_number);
%     
%     % 尝试读取音频文件
%     try
%         [audio1, fs] = audioread(audio1_file);
%         [audio2, fs] = audioread(audio2_file);
%         [audio3, fs] = audioread(audio3_file);
%         [audio4, fs] = audioread(audio4_file);
%     catch
%         fprintf('无法读取文件: %d\n', experiment_number);
%         distances(experiment_number) = NaN;  % 或使用 -1 作为特殊值
%         continue;  % 跳过本次循环
%     end
%     
%     %% 计算时延
%     audio_files = {audio1, audio2, audio3, audio4};
%     
%     % 调用函数，计算时延矩阵
%     timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);
%     
%     % 输出时延矩阵
%     disp(['实验 ' num2str(experiment_number) ' 的时延矩阵 (保留8位小数):']);
%     disp(timeDelayMatrix);
%     
%     %% 定位
%     gridStep = 0.05;  % 网格步长 (m)
%     
%     % 调用函数
%     [bestLocation, distanceToOrigin, Jp] = calculate_search_locate_source(mic_positions, timeDelayMatrix, c, gridStep);
%     
%     % 存储距离
%     distances(experiment_number) = distanceToOrigin;
%     
%     % 输出结果
%     fprintf('实验 %d 的最佳声源位置: (%.8f, %.8f, %.8f)\n', experiment_number, bestLocation(1), bestLocation(2), bestLocation(3));
%     fprintf('实验 %d 的最佳位置到原点的距离: %.8f\n', experiment_number, distanceToOrigin);
% end
% 
% % 输出所有距离
% disp('所有文件的距离:');
% disp(distances);
% 









%% 只输出距离
% % main_script.m
% % 主程序 - 负责读取音频文件并调用各个功能模块
% 
% % 常量定义
% c = 343;  % 声速（m/s）
% % fs = 16000;  % 采样频率（Hz）
% 
% % 麦克风的三维坐标 (x, y, z) 单位为米
% mic_positions = [
%     -0.02150, +0.03725, +0;
%     +0.02150, +0.03725, +0; 
%     +0.02150, -0.03725, +0;
%     -0.02150, -0.03725, +0
% ];
% 
% 
% % 要处理的实验文件编号
% numFiles = 20;  % 假设有40个文件
% distances = zeros(numFiles, 1);  % 存储每个文件的距离
% 
% for experiment_number = 1:numFiles
%     % 构建文件路径
%     audio1_file = sprintf('Laboratory/实验2/%d/音频 1-3.wav', experiment_number);
%     audio2_file = sprintf('Laboratory/实验2/%d/音频 1-4.wav', experiment_number);
%     audio3_file = sprintf('Laboratory/实验2/%d/音频 1-5.wav', experiment_number);
%     audio4_file = sprintf('Laboratory/实验2/%d/音频 1-6.wav', experiment_number); 
%     
%     % 尝试读取音频文件
%     try
%         [audio1, fs] = audioread(audio1_file);
%         [audio2, fs] = audioread(audio2_file);
%         [audio3, fs] = audioread(audio3_file);
%         [audio4, fs] = audioread(audio4_file);
%     catch
%         fprintf('无法读取文件: %d\n', experiment_number);
%         distances(experiment_number) = NaN;  % 或使用 -1 作为特殊值
%         continue;  % 跳过本次循环
%     end
%     
%     %% 计算时延
%     audio_files = {audio1, audio2, audio3, audio4};
%     
%     % 调用函数，计算时延矩阵
%     timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);
%     
%     % 输出时延矩阵
%     disp(['实验 ' num2str(experiment_number) ' 的时延矩阵 (保留8位小数):']);
%     disp(timeDelayMatrix);
%     
%     %% 定位
%     gridStep = 0.05;  % 网格步长 (m)
%     
%     % 调用函数
%     [bestLocation, distanceToOrigin, Jp] = calculate_search_locate_source(mic_positions, timeDelayMatrix, c, gridStep);
%     
%     % 存储距离
%     distances(experiment_number) = distanceToOrigin;
%     
%     % 输出结果
%     fprintf('实验 %d 的最佳声源位置: (%.8f, %.8f, %.8f)\n', experiment_number, bestLocation(1), bestLocation(2), bestLocation(3));
%     fprintf('实验 %d 的最佳位置到原点的距离: %.8f\n', experiment_number, distanceToOrigin);
% end
% 
% % 输出所有距离
% disp('所有文件的距离:');
% disp(distances);
% 


%%  全局搜索
% % main_script.m
% % 主程序 - 负责读取音频文件并调用各个功能模块
% 
% % ==== 常量定义 ====
% c = 343;  % 声速（m/s）
% 
% % ==== 麦克风的三维坐标 (x, y, z) 单位为米 ====
% mic_positions = [
%     -0.02150, +0.03725, +0;
%     +0.02150, +0.03725, +0; 
%     +0.02150, -0.03725, +0;
%     -0.02150, -0.03725, +0
% ];
% 
% % ==== 要处理的实验文件数量 ====
% numFiles = 20;  
% 
% % ==== 结果存储 ====
% distances        = zeros(numFiles, 1);  % 距离
% azimuth_angles   = zeros(numFiles, 1);  % 方位角 (deg)
% elevation_angles = zeros(numFiles, 1);  % 俯仰角 (deg)
% sourceLocations  = zeros(numFiles, 3);  % 声源位置 (x,y,z)
% 
% % ==== 主循环 ====
% for experiment_number = 1:1
%     % 构建文件路径
%     audio1_file = sprintf('Laboratory/实验4/%d/音频 1-3.wav', experiment_number);
%     audio2_file = sprintf('Laboratory/实验4/%d/音频 1-4.wav', experiment_number);
%     audio3_file = sprintf('Laboratory/实验4/%d/音频 1-5.wav', experiment_number);
%     audio4_file = sprintf('Laboratory/实验4/%d/音频 1-6.wav', experiment_number); 
% 
% %      audio1_file = sprintf('第三次试验记录 22/13/%d/音频 1-3.wav', experiment_number);
% %      audio2_file = sprintf('第三次试验记录 22/13/%d/音频 1-4.wav', experiment_number);
% %      audio3_file = sprintf('第三次试验记录 22/13/%d/音频 1-5.wav', experiment_number);
% %      audio4_file = sprintf('第三次试验记录 22/13/%d/音频 1-6.wav', experiment_number);   
%   
% %      audio1_file = sprintf('极限位置/35/%d/音频 1-3.wav', experiment_number);
% %      audio2_file = sprintf('极限位置/35/%d/音频 1-4.wav', experiment_number);
% %      audio3_file = sprintf('极限位置/35/%d/音频 1-5.wav', experiment_number);
% %      audio4_file = sprintf('极限位置/35/%d/音频 1-6.wav', experiment_number);   
% 
% 
%     % 尝试读取音频文件
%     try
%         [audio1, fs] = audioread(audio1_file);
%         [audio2, fs] = audioread(audio2_file);
%         [audio3, fs] = audioread(audio3_file);
%         [audio4, fs] = audioread(audio4_file);
%     catch
%         fprintf('⚠️ 无法读取实验 %d 的音频文件，跳过。\n', experiment_number);
%         distances(experiment_number)        = NaN;
%         azimuth_angles(experiment_number)   = NaN;
%         elevation_angles(experiment_number) = NaN;
%         sourceLocations(experiment_number,:) = [NaN,NaN,NaN];
%         continue;  % 跳过本次循环
%     end
%     
%     %% ==== 计算时延 ====
%     audio_files = {audio1, audio2, audio3, audio4};
%     timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);
% 
%     disp(['实验 ' num2str(experiment_number) ' 的时延矩阵 (保留8位小数):']);
%     disp(timeDelayMatrix);
%     
%     %% ==== 定位 ====
%     gridStep = 0.05;  % 网格步长 (m)
% 
%     [bestLocation, distanceToOrigin, alpha_deg, elevation_deg, Jp] = ...
%         calculate_search_locate_source(mic_positions, timeDelayMatrix, c, gridStep);
%     
%     % ==== 保存结果 ====
%     distances(experiment_number)        = distanceToOrigin;
%     azimuth_angles(experiment_number)   = alpha_deg;
%     elevation_angles(experiment_number) = elevation_deg;
%     sourceLocations(experiment_number,:)= bestLocation;
% 
%     % ==== 输出单次结果 ====
%     disp(['实验 ' num2str(experiment_number) ' 的声源位置:']);
%     disp(bestLocation);
%     disp(['声源到原点的距离: ' num2str(distanceToOrigin)]);
%     disp(['方位角 (Azimuth): ' num2str(alpha_deg) ' degrees']);
%     disp(['俯仰角 (Elevation): ' num2str(elevation_deg) ' degrees']);
%     disp('------------------------------------------');
% end
% 
% %% ==== 汇总输出（纯数值，每行一个，缺失值为空行） ====
% disp('所有文件的距离:');
% for i = 1:numFiles
%     if isnan(distances(i))
%         fprintf('\n');
%     else
%         fprintf('%.8f\n', distances(i));
%     end
% end
% fprintf('\n');
% 
% disp('所有文件的方位角:');
% for i = 1:numFiles
%     if isnan(azimuth_angles(i))
%         fprintf('\n');
%     else
%         fprintf('%.3f\n', azimuth_angles(i));
%     end
% end
% fprintf('\n');
% 
% disp('所有文件的俯仰角:');
% for i = 1:numFiles
%     if isnan(elevation_angles(i))
%         fprintf('\n');
%     else
%         fprintf('%.3f\n', elevation_angles(i));
%     end
% end
% fprintf('\n');


%% 全局搜索 输出时间
% main_script.m
% 主程序 - 负责读取音频文件并调用各个功能模块

% ==== 常量定义 ====
c = 343;  % 声速（m/s）

% ==== 麦克风的三维坐标 (x, y, z) 单位为米 ====
mic_positions = [
    -0.02150, +0.03725, +0;
    +0.02150, +0.03725, +0; 
    +0.02150, -0.03725, +0;
    -0.02150, -0.03725, +0
];

% ==== 要处理的实验文件数量 ====
numFiles = 20;  

% ==== 结果存储 ====
distances        = zeros(numFiles, 1);  % 距离
azimuth_angles   = zeros(numFiles, 1);  % 方位角 (deg)
elevation_angles = zeros(numFiles, 1);  % 俯仰角 (deg)
sourceLocations  = zeros(numFiles, 3);  % 声源位置 (x,y,z)

% ==== 开始计时 ====
tic;  

% ==== 主循环 ====
% for experiment_number = 1:1
%     % 构建文件路径
%     audio1_file = sprintf('Laboratory/实验4/%d/音频 1-3.wav', experiment_number);
%     audio2_file = sprintf('Laboratory/实验4/%d/音频 1-4.wav', experiment_number);
%     audio3_file = sprintf('Laboratory/实验4/%d/音频 1-5.wav', experiment_number);
%     audio4_file = sprintf('Laboratory/实验4/%d/音频 1-6.wav', experiment_number);
% 
%     % 尝试读取音频文件
%     try
%         [audio1, fs] = audioread(audio1_file);
%         [audio2, fs] = audioread(audio2_file);
%         [audio3, fs] = audioread(audio3_file);
%         [audio4, fs] = audioread(audio4_file);
%     catch
%         fprintf('⚠️ 无法读取实验 %d 的音频文件，跳过。\n', experiment_number);
%         distances(experiment_number)        = NaN;
%         azimuth_angles(experiment_number)   = NaN;
%         elevation_angles(experiment_number) = NaN;
%         sourceLocations(experiment_number,:) = [NaN,NaN,NaN];
%         continue;  % 跳过本次循环
%     end
% 
%     %% ==== 计算时延 ====
%     audio_files = {audio1, audio2, audio3, audio4};
%     timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);
% 
%     disp(['实验 ' num2str(experiment_number) ' 的时延矩阵 (保留8位小数):']);
%     disp(timeDelayMatrix);
%     
%     %% ==== 定位 ====
%     gridStep = 0.05;  % 网格步长 (m)
% 
%     [bestLocation, distanceToOrigin, alpha_deg, elevation_deg, Jp] = ...
%         calculate_search_locate_source(mic_positions, timeDelayMatrix, c, gridStep);
%     
%     % ==== 保存结果 ====
%     distances(experiment_number)        = distanceToOrigin;
%     azimuth_angles(experiment_number)   = alpha_deg;
%     elevation_angles(experiment_number) = elevation_deg;
%     sourceLocations(experiment_number,:)= bestLocation;
% 
%     % ==== 输出单次结果 ====
%     disp(['实验 ' num2str(experiment_number) ' 的声源位置:']);
%     disp(bestLocation);
%     disp(['声源到原点的距离: ' num2str(distanceToOrigin)]);
%     disp(['方位角 (Azimuth): ' num2str(alpha_deg) ' degrees']);
%     disp(['俯仰角 (Elevation): ' num2str(elevation_deg) ' degrees']);
%     disp('------------------------------------------');
% end
% 
% % ==== 结束计时 ====
% elapsed_time = toc;
% fprintf('✅ 所有实验运行完毕，总耗时：%.2f 秒。\n', elapsed_time);
% 
% %% ==== 汇总输出（纯数值，每行一个，缺失值为空行） ====
% disp('所有文件的距离:');
% for i = 1:numFiles
%     if isnan(distances(i))
%         fprintf('\n');
%     else
%         fprintf('%.8f\n', distances(i));
%     end
% end
% fprintf('\n');
% 
% disp('所有文件的方位角:');
% for i = 1:numFiles
%     if isnan(azimuth_angles(i))
%         fprintf('\n');
%     else
%         fprintf('%.3f\n', azimuth_angles(i));
%     end
% end
% fprintf('\n');
% 
% disp('所有文件的俯仰角:');
% for i = 1:numFiles
%     if isnan(elevation_angles(i))
%         fprintf('\n');
%     else
%         fprintf('%.3f\n', elevation_angles(i));
%     end
% end
% fprintf('\n');

% ==== 主循环 ====
for experiment_number = 1:1

    fprintf('\n=========================================\n');
    fprintf('=========== 实验 %d 时间统计 ===========\n', experiment_number);
    fprintf('=========================================\n');

    % ===== 整体计时 =====
    total_tic = tic;


    %% ------------------ 1. 读取音频文件 ------------------
    t_audio = tic;
    audio1_file = sprintf('Laboratory/实验10/%d/音频 1-3.wav', experiment_number);
    audio2_file = sprintf('Laboratory/实验10/%d/音频 1-4.wav', experiment_number);
    audio3_file = sprintf('Laboratory/实验10/%d/音频 1-5.wav', experiment_number);
    audio4_file = sprintf('Laboratory/实验10/%d/音频 1-6.wav', experiment_number);

    try
        [audio1, fs] = audioread(audio1_file);
        [audio2, fs] = audioread(audio2_file);
        [audio3, fs] = audioread(audio3_file);
        [audio4, fs] = audioread(audio4_file);
    catch
        fprintf('⚠️ 无法读取实验 %d 的音频文件，跳过。\n', experiment_number);
        continue;
    end
    t_audio_elapsed = toc(t_audio);
    fprintf('======= Audio Loading Time =======\n');
    fprintf('%.4f 秒\n\n', t_audio_elapsed);


    %% ------------------ 2. 计算时延 ------------------
    t_tdoa = tic;
    audio_files = {audio1, audio2, audio3, audio4};
    timeDelayMatrix = estimate_time_delay_matrix(audio_files, fs);
    t_tdoa_elapsed = toc(t_tdoa);

    fprintf('======= TDOA Estimation Time =======\n');
    fprintf('%.4f 秒\n\n', t_tdoa_elapsed);


    %% ------------------ 3. 全局搜索定位 ------------------
    t_global = tic;
    gridStep = 0.05;

    [bestLocation, distanceToOrigin, alpha_deg, elevation_deg, Jp] = ...
        calculate_search_locate_source(mic_positions, timeDelayMatrix, c, gridStep);
    t_global_elapsed = toc(t_global);

    fprintf('======= Global Search Time =======\n');
    fprintf('%.4f 秒\n\n', t_global_elapsed);


    %% ------------------ 4. 保存结果 ------------------
    distances(experiment_number)        = distanceToOrigin;
    azimuth_angles(experiment_number)   = alpha_deg;
    elevation_angles(experiment_number) = elevation_deg;
    sourceLocations(experiment_number,:)= bestLocation;


    %% ------------------ 5. 实验总耗时 ------------------
    total_elapsed = toc(total_tic);
    fprintf('======= Total Time (Experiment %d) =======\n', experiment_number);
    fprintf('%.4f 秒\n', total_elapsed);
    fprintf('=========================================\n\n');

end
