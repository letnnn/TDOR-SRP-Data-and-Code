% function [bestLocation, distanceToOrigin, Jp] = calculate_search_locate_source(mic_positions, timeDelays, c, gridStep)
%     % 输入参数:
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % c: 声速 (m/s)
%     % gridStep: 网格步长 (m)
%     
%     % 定义搜索网格的范围
%     xRange = -1:gridStep:1;  % 定义x轴的搜索范围
%     yRange = -1:gridStep:1;  % 定义y轴的搜索范围
%     zRange = 0:gridStep:2;   % 定义z轴的搜索范围
%     
%     % 初始化最小值
%     minJp = Inf;
%     bestLocation = [0, 0, 0];
%     
%     % 初始化目标函数的存储矩阵
%     Jp = zeros(length(xRange), length(yRange), length(zRange));
%     
%     % 遍历搜索空间中的每个点
%     for xi = 1:length(xRange)
%         for yi = 1:length(yRange)
%             for zi = 1:length(zRange)
%                 % 当前的搜索位置
%                 p = [xRange(xi), yRange(yi), zRange(zi)];
%                 
%                 % 计算目标函数 J(p) 根据公式 (4-36)
%                 J = 0;
%                 for i = 1:size(mic_positions, 1) - 1
%                     for j = i+1:size(mic_positions, 1)
%                         r_i = norm(p - mic_positions(i, :));  % 位置 p 到麦克风 i 的距离
%                         r_j = norm(p - mic_positions(j, :));  % 位置 p 到麦克风 j 的距离
%                         delta_ij = r_i - r_j;  % 两个麦克风之间的距离差
%                         cTij = c * timeDelays(i, j);  % 计算声速与时延差的乘积
%                         J = J + (delta_ij - cTij)^2;  % 累积平方误差
%                     end
%                 end
%                 
%                 % 记录目标函数值
%                 Jp(xi, yi, zi) = J;
%                 
%                 % 如果找到更小的 J(p)，更新最优位置
%                 if J < minJp
%                     minJp = J;
%                     bestLocation = p;
%                 end
%             end
%         end
%     end
%     
%     % 计算最佳位置到坐标原点的距离
%     distanceToOrigin = norm(bestLocation);
%     
%     % 输出最佳位置和到原点的距离
%     %fprintf('最佳声源位置: (%.8f, %.8f, %.8f)\n', bestLocation(1), bestLocation(2), bestLocation(3));
%     %fprintf('最佳位置到原点的距离: %.8f\n', distanceToOrigin);
% end


%% 图显示 2D+3D
% function [bestLocation, distanceToOrigin, Jp] = calculate_search_locate_source(mic_positions, timeDelays, c, gridStep)
%     % 输入参数:
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % c: 声速 (m/s)
%     % gridStep: 网格步长 (m)
%     
%     % 定义搜索网格的范围
%     xRange = -2:gridStep:2;  % x 方向的搜索范围
%     yRange = -2:gridStep:2;  % y 方向的搜索范围
%     zRange = 0:gridStep:2;   % z 方向的搜索范围
%     
%     % 初始化最小值
%     minJp = Inf;
%     bestLocation = [0, 0, 0];
%     
%     % 初始化目标函数的存储矩阵
%     Jp = zeros(length(xRange), length(yRange), length(zRange));
%     
%     % 遍历搜索空间中的每个点
%     for xi = 1:length(xRange)
%         for yi = 1:length(yRange)
%             for zi = 1:length(zRange)
%                 % 当前的搜索位置
%                 p = [xRange(xi), yRange(yi), zRange(zi)];
%                 
%                 % 计算目标函数 J(p) 根据公式 (4-36)
%                 J = 0;
%                 for i = 1:size(mic_positions, 1) - 1
%                     for j = i+1:size(mic_positions, 1)
%                         r_i = norm(p - mic_positions(i, :));  % 位置 p 到麦克风 i 的距离
%                         r_j = norm(p - mic_positions(j, :));  % 位置 p 到麦克风 j 的距离
%                         delta_ij = r_i - r_j;  % 两个麦克风之间的距离差
%                         cTij = c * timeDelays(i, j);  % 计算声速与时延差的乘积
%                         J = J + (delta_ij - cTij)^2;  % 累积平方误差
%                     end
%                 end
%                 
%                 % 记录目标函数值
%                 Jp(xi, yi, zi) = J;
%                 
%                 % 如果找到更小的 J(p)，更新最优位置
%                 if J < minJp
%                     minJp = J;
%                     bestLocation = p;
%                 end
%             end
%         end
%     end
%     
%     % 计算最佳位置到坐标原点的距离
%     distanceToOrigin = norm(bestLocation);
%     
%     % 输出最佳位置和到原点的距离
%     %fprintf('最佳位置: [%.3f, %.3f, %.3f]\n', bestLocation);
%     %fprintf('最佳位置到原点的距离: %.8f\n', distanceToOrigin);
%     
%     % 可视化目标函数值
%     [xGrid, yGrid] = meshgrid(xRange, yRange);
%     
%     % 绘制目标函数 Jp 的 2D 图像
%     figure;
%     subplot(1, 2, 1);
%     imagesc(xRange, yRange, Jp(:, :, 1));
%     colorbar;
%     title('目标函数 J(p) 在 z = 0 层');
%     xlabel('x (m)');
%     ylabel('y (m)');
%     
%     % 绘制目标函数 Jp 的 3D 图像
%     subplot(1, 2, 2);
%     surf(xRange, yRange, Jp(:, :, 1), 'EdgeColor', 'none');
%     colorbar;
%     title('目标函数 J(p) 的 3D 图像');
%     xlabel('x (m)');
%     ylabel('y (m)');
%     zlabel('J(p)');
%     
%     % 绘制最佳位置
%     hold on;
%     plot3(bestLocation(1), bestLocation(2), min(Jp(:)), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
%     legend('目标函数值', '最佳位置');
%     hold off;
% end




%% 只有距离
% function [bestLocation, distanceToOrigin, Jp] = calculate_search_locate_source(mic_positions, timeDelays, c, gridStep)
%     % 输入参数:
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % c: 声速 (m/s)
%     % gridStep: 网格步长 (m)
%     
%     % 定义搜索网格的范围
%     xRange = -2:gridStep:2;  % x 方向的搜索范围
%     yRange = -2:gridStep:2;  % y 方向的搜索范围
%     zRange = 0:gridStep:2;   % z 方向的搜索范围   
%     % 初始化最小值
%     minJp = Inf;
%     bestLocation = [0, 0, 0];    
%     % 初始化目标函数的存储矩阵
%     Jp = zeros(length(xRange), length(yRange), length(zRange));   
%     % 遍历搜索空间中的每个点
%     for xi = 1:length(xRange)
%         for yi = 1:length(yRange)
%             for zi = 1:length(zRange)
%                 % 当前的搜索位置
%                 p = [xRange(xi), yRange(yi), zRange(zi)];
%                 
%                 % 计算目标函数 J(p) 根据公式 (4-36)
%                 J = 0;
%                 for i = 1:size(mic_positions, 1) - 1
%                     for j = i+1:size(mic_positions, 1)
%                         r_i = norm(p - mic_positions(i, :));  % 位置 p 到麦克风 i 的距离
%                         r_j = norm(p - mic_positions(j, :));  % 位置 p 到麦克风 j 的距离
%                         delta_ij = r_i - r_j;  % 两个麦克风之间的距离差
%                         cTij = c * timeDelays(i, j);  % 计算声速与时延差的乘积
%                         J = J + (delta_ij - cTij)^2;  % 累积平方误差
%                     end
%                 end               
%                 % 记录目标函数值
%                 Jp(xi, yi, zi) = J;               
%                 % 如果找到更小的 J(p)，更新最优位置
%                 if J < minJp
%                     minJp = J;
%                     bestLocation = p;
%                 end
%             end
%         end
%     end
%     
%     % 计算最佳位置到坐标原点的距离
%     distanceToOrigin = norm(bestLocation);
%     
%     % 输出最佳位置和到原点的距离
%     fprintf('最佳位置: [%.3f, %.3f, %.3f]\n', bestLocation);
%     fprintf('最佳位置到原点的距离: %.8f\n', distanceToOrigin);
%     
%     % 可视化目标函数值
%     [XGrid, YGrid, ZGrid] = meshgrid(xRange, yRange, zRange);  % 生成 3D 网格
%     
%     % 绘制目标函数 Jp 的 3D 图像
%     figure;
%     
%     % 选择一个切片 z = 0
%     subplot(1, 2, 1);
%     [XSlice, YSlice] = meshgrid(xRange, yRange);
%     JSlice = squeeze(Jp(:, :, 1));  % 选择 z = 0 切片
%     surf(XSlice, YSlice, JSlice, 'EdgeColor', 'none');
%     colorbar;
%     title('目标函数 J(p) 在 z = 0 层');
%     xlabel('x (m)');
%     ylabel('y (m)');
%     zlabel('J(p)');
%     
%     % 绘制目标函数 Jp 的 3D 图像
%     subplot(1, 2, 2);
%     % 使用三维切片展示目标函数
%     slice(XGrid, YGrid, ZGrid, Jp, [], [], [0]);  % 可调整切片位置
%     colormap jet;
%     colorbar;
%     title('目标函数 J(p) 的 3D 图像');
%     xlabel('x (m)');
%     ylabel('y (m)');
%     zlabel('z (m)');
%     
%     % 绘制最佳位置
%     hold on;
%     plot3(bestLocation(1), bestLocation(2), bestLocation(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
%     legend('目标函数值', '最佳位置');
%     hold off;
% end



%% 输出角度距离
function [bestLocation, distanceToOrigin, alpha_deg, elevation_deg, Jp] = calculate_search_locate_source(mic_positions, timeDelays, c, gridStep)
    % 输入参数:
    % mic_positions: 麦克风坐标矩阵 (N x 3)
    % timeDelays: TDOA矩阵 (N x N)
    % c: 声速 (m/s)
    % gridStep: 网格步长 (m)
    %
    % 输出参数:
    % bestLocation: 最优位置 (x,y,z)
    % distanceToOrigin: 到原点的距离
    % alpha_deg: 方位角 (度)
    % elevation_deg: 俯仰角 (度)
    % Jp: 目标函数矩阵

    % 定义搜索网格的范围
    xRange = -2:gridStep:2;  % x 方向的搜索范围
    yRange = -2:gridStep:2;  % y 方向的搜索范围
    zRange = 0:gridStep:2;   % z 方向的搜索范围   
    
    % 初始化最小值
    minJp = Inf;
    bestLocation = [0, 0, 0];    
    
    % 初始化目标函数的存储矩阵
    Jp = zeros(length(xRange), length(yRange), length(zRange));   
    
    % 遍历搜索空间中的每个点
    for xi = 1:length(xRange)
        for yi = 1:length(yRange)
            for zi = 1:length(zRange)
                % 当前的搜索位置
                p = [xRange(xi), yRange(yi), zRange(zi)];
                
                % 计算目标函数 J(p)
                J = 0;
                for i = 1:size(mic_positions, 1) - 1
                    for j = i+1:size(mic_positions, 1)
                        r_i = norm(p - mic_positions(i, :));  
                        r_j = norm(p - mic_positions(j, :));  
                        delta_ij = r_i - r_j;  
                        cTij = c * timeDelays(i, j);  
                        J = J + (delta_ij - cTij)^2;  
                    end
                end               

                % 记录目标函数值
                Jp(xi, yi, zi) = J;               

                % 如果找到更小的 J(p)，更新最优位置
                if J < minJp
                    minJp = J;
                    bestLocation = p;
                end
            end
        end
    end
    
    % ====== 计算输出结果 ======
    % 到原点的距离
    distanceToOrigin = norm(bestLocation);
    
    % 方位角 (绕 z 轴，从 x 轴正方向起算)
    alpha_rad = atan2(bestLocation(2), bestLocation(1));
    alpha_deg = rad2deg(alpha_rad);
    
    % 俯仰角 (与水平面的夹角)
    elevation_rad = atan2(bestLocation(3), sqrt(bestLocation(1)^2 + bestLocation(2)^2));
    elevation_deg = rad2deg(elevation_rad);
    
    % ====== 输出到命令行 ======
    fprintf('最佳位置: [%.3f, %.3f, %.3f]\n', bestLocation);
    fprintf('到原点的距离: %.8f m\n', distanceToOrigin);
    fprintf('方位角 (Azimuth): %.3f degrees\n', alpha_deg);
    fprintf('俯仰角 (Elevation): %.3f degrees\n', elevation_deg);
    
   % ====== Visualization ======
[XGrid, YGrid, ZGrid] = meshgrid(xRange, yRange, zRange);  

figure;

% Left: slice at z = 0
subplot(1,2,1);
[XSlice, YSlice] = meshgrid(xRange, yRange);
JSlice = squeeze(Jp(:, :, 1));  
surf(XSlice, YSlice, JSlice, 'EdgeColor', 'none');
colorbar;
title('Objective Function J(p) at z = 0', 'FontName', 'Times New Roman', 'FontSize', 12);
xlabel('x (m)', 'FontName', 'Times New Roman', 'FontSize', 12);
ylabel('y (m)', 'FontName', 'Times New Roman', 'FontSize', 12);
zlabel('J(p)', 'FontName', 'Times New Roman', 'FontSize', 12);

% 右边 3D 可视化
subplot(1,2,2);
Xv = XGrid(:);
Yv = YGrid(:);
Zv = ZGrid(:);
Jv = Jp(:);

% 用 scatter3 显示，每个点颜色反映 J(p)
scatter3(Xv, Yv, Zv, 50, Jv, 'filled');  
colormap jet;
caxis([0 0.06]);  % 限制颜色刻度
colorbar;
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
title('J(p) in 3D search volume');
set(gca,'FontName','Times New Roman');  

hold on;
plot3(bestLocation(1), bestLocation(2), bestLocation(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);

grid on; 
axis([min(Xv) max(Xv) min(Yv) max(Yv) 0 0.2]);  % z 方向缩小，高度比长宽小
axis equal;
legend('J(p) value', 'Best location');


end

















%% 去掉可视化
% function [bestLocation, distanceToOrigin, alpha_deg, elevation_deg, Jp] = calculate_search_locate_source(mic_positions, timeDelays, c, gridStep)
%     % 输入参数:
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % c: 声速 (m/s)
%     % gridStep: 网格步长 (m)
%     %
%     % 输出参数:
%     % bestLocation: 最优位置 (x,y,z)
%     % distanceToOrigin: 到原点的距离
%     % alpha_deg: 方位角 (度)
%     % elevation_deg: 俯仰角 (度)
%     % Jp: 目标函数矩阵
% 
%     % 定义搜索网格的范围
%     xRange = -2:gridStep:2;  
%     yRange = -2:gridStep:2;  
%     zRange = 0:gridStep:2;   
%     
%     % 初始化最小值
%     minJp = Inf;
%     bestLocation = [0, 0, 0];    
%     
%     % 初始化目标函数矩阵
%     Jp = zeros(length(xRange), length(yRange), length(zRange));   
%     
%     % 遍历搜索空间
%     for xi = 1:length(xRange)
%         for yi = 1:length(yRange)
%             for zi = 1:length(zRange)
%                 p = [xRange(xi), yRange(yi), zRange(zi)];
%                 J = 0;
%                 for i = 1:size(mic_positions, 1) - 1
%                     for j = i+1:size(mic_positions, 1)
%                         r_i = norm(p - mic_positions(i, :));  
%                         r_j = norm(p - mic_positions(j, :));  
%                         delta_ij = r_i - r_j;  
%                         cTij = c * timeDelays(i, j);  
%                         J = J + (delta_ij - cTij)^2;  
%                     end
%                 end
%                 Jp(xi, yi, zi) = J;  
%                 if J < minJp
%                     minJp = J;
%                     bestLocation = p;
%                 end
%             end
%         end
%     end
%     
%     % 计算输出结果
%     distanceToOrigin = norm(bestLocation);
%     alpha_rad = atan2(bestLocation(2), bestLocation(1));
%     alpha_deg = rad2deg(alpha_rad);
%     elevation_rad = atan2(bestLocation(3), sqrt(bestLocation(1)^2 + bestLocation(2)^2));
%     elevation_deg = rad2deg(elevation_rad);
% end
% 
% 
% 
% 
