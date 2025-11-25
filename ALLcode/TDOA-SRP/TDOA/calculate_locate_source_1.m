%% 六祖方程 加参数方程
function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs,m, n, t)
    speed_of_sound = 343;  % 声速 (m/s)
    % 获取麦克风数量
    numMics = size(mic_positions, 1);

    % 初始化方程存储数组
    equations_func = @(sourceLocation) [
        (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2); % t12
        (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3); % t13
        (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4); % t14
        (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3); % t23
        (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4); % t24
        (norm(sourceLocation - mic_positions(3, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4); % t34
        
    ];
    
    % 初始猜测的声源位置
    initial_guess = [0, 0, 0];  % 声源初始位置猜测
    
    % 设置位置的约束条件
    lb = [-Inf, -Inf, 0];  % 下界：第三个值大于0
    ub = [Inf, Inf, Inf];  % 上界：没有限制

    % 使用非线性最小二乘法来求解
    options = optimoptions('lsqnonlin', 'Display', 'off');
    [sourceLocation, resnorm] = lsqnonlin(equations_func, initial_guess, lb, ub, options);
    
    % 计算声源距离原点的距离
    distance = norm(sourceLocation);
    
    % 输出估计的声源位置和距离
    fprintf('估计的声源位置: (%.8f, %.8f, %.8f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
    fprintf('声源距离原点的距离: %.8f\n', distance);
    fprintf('优化残差平方和: %.8f\n', resnorm);
end

% function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs, m, n, t)
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % fs: 采样频率 (Hz)
%     % m, n, t: 直线方向向量的分量
%     
%     speed_of_sound = 343;  % 声速 (m/s)
% 
%     % 获取麦克风数量
%     numMics = size(mic_positions, 1);
%     
%     % 定义额外的参数 s
%     % 方程将依赖于 s，因此需要将其包含在优化中
%     equations_func = @(params) [
%         (norm(params(1:3) - mic_positions(1, :)) - norm(params(1:3) - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2); % t12
%         (norm(params(1:3) - mic_positions(1, :)) - norm(params(1:3) - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3); % t13
%         (norm(params(1:3) - mic_positions(1, :)) - norm(params(1:3) - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4); % t14
%         (norm(params(1:3) - mic_positions(2, :)) - norm(params(1:3) - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3); % t23
%         (norm(params(1:3) - mic_positions(2, :)) - norm(params(1:3) - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4); % t24
%         (norm(params(1:3) - mic_positions(3, :)) - norm(params(1:3) - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4); % t34
%         params(1) - m * params(4); % x - m*s = 0
%         params(2) - n * params(4); % y - n*s = 0
%         params(3) - t * params(4); % z - t*s = 0
%     ];
%     
%     % 初始猜测的声源位置和参数
%     initial_guess = [0, 0, 0, 0];  % [x, y, z, s] 初始位置猜测
%     
%     % 设置位置的约束条件
%     lb = [-5, -5, 0, 0];  % 下界：x, y, z 没有限制，s ≥ 0
%     ub = [5, 5, 5, 5];   % 上界：没有限制
% 
%     % 使用非线性最小二乘法来求解
%     options = optimoptions('lsqnonlin', 'Display', 'off');
%     [params, resnorm] = lsqnonlin(equations_func, initial_guess, lb, ub, options);
%     
%     % 提取优化结果中的声源位置和 s
%     sourceLocation = params(1:3);
%     s = params(4);
%     
%     % 计算声源距离原点的距离
%     distance = norm(sourceLocation);
%     
%     % 输出估计的声源位置和距离
%     fprintf('估计的声源位置: (%.8f, %.8f, %.8f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
%     fprintf('声源距离原点的距离: %.8f\n', distance);
%     fprintf('优化残差平方和: %.8f\n', resnorm);
% end


% %% 添加参数方程约束
% function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs, m, n, t)
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % fs: 采样频率 (Hz)
%     % m, n, t: 直线方向向量的分量
%     
%     speed_of_sound = 343;  % 声速 (m/s)
%     numMics = size(mic_positions, 1);
%     
%     % 初始化方程存储数组
%     equations_func = @(sourceLocation) [
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2); % t12
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3); % t13
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4); % t14
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3); % t23
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4); % t24
%         (norm(sourceLocation - mic_positions(3, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4); % t34
%     ];
%     
%     % 定义目标函数（残差的平方和）
%     objective_func = @(sourceLocation) norm(equations_func(sourceLocation))^2;
%     
%     % 定义非线性约束函数（声源位置在直线上）
%     % 直线的参数方程为: x = m*s, y = n*s, z = t*s
%     % 变换到一般形式：x - m*s = 0, y - n*s = 0, z - t*s = 0
%     function [c, ceq] = nonlcon(sourceLocation, m, n, t)
%         s = sourceLocation(3) / t;
%         ceq = [
%             sourceLocation(1) - m * s;
%             sourceLocation(2) - n * s;
%             sourceLocation(3) - t * s
%         ];
%         c = [];  % 没有不等式约束
%     end
%     
%     % 初始猜测的声源位置
%     initial_guess = [0, 0, 0];  % 声源初始位置猜测
%     
%     % 设置位置的约束条件
%     lb = [-Inf, -Inf, 0];  % 下界：第三个值大于0
%     ub = [Inf, Inf, Inf];  % 上界：没有限制
%     
%     % 优化选项
%     options = optimoptions('fmincon', 'Algorithm', 'sqp', ...
%         'Display', 'off', 'TolFun', 1e-6, 'TolX', 1e-6, ...
%         'SpecifyObjectiveGradient', false, 'SpecifyConstraintGradient', false);
%     
%     % 优化
%     [sourceLocation, fval, exitflag, output] = fmincon(@(x) objective_func(x), initial_guess, [], [], [], [], lb, ub, @(x) nonlcon(x, m, n, t), options);
% 
%     % 计算声源距离原点的距离
%     distance = norm(sourceLocation);
%     
%     % 输出估计的声源位置和距离
%     fprintf('估计的声源位置: (%.8f, %.8f, %.8f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
%     fprintf('声源距离原点的距离: %.8f\n', distance);
%     fprintf('优化残差平方和: %.8f\n', fval);
% end




%%
% function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs)
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % fs: 采样频率 (Hz)
%     
%     speed_of_sound = 343;  % 声速 (m/s)
%     numMics = size(mic_positions, 1);
%     
%     % 初始化方程存储数组
%     equations_func = @(sourceLocation) [
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2); % t12
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3); % t13
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4); % t14
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3); % t23
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4); % t24
%         (norm(sourceLocation - mic_positions(3, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4); % t34
%     ];
%     
%     % 初始猜测的声源位置
%     initial_guess = [0, 0, 0];  % 声源初始位置猜测
%     
%     % 设置位置的约束条件
%     lb = [-Inf, -Inf, 0];  % 下界：第三个值大于0
%     ub = [Inf, Inf, Inf];  % 上界：没有限制
%     
%     % 拟牛顿法（BFGS）优化
%     options = optimset('fminunc');
%     options.Display = 'off';
%     options.TolFun = 1e-6;
%     options.TolX = 1e-6;
%     options.Algorithm = 'quasi-newton';  % 使用拟牛顿法
% 
%     % 优化
%     [sourceLocation, resnorm, exitflag, output] = fminunc(@(x) norm(equations_func(x)), initial_guess, options);
% 
%     % 计算声源距离原点的距离
%     distance = norm(sourceLocation);
%     
%     % 输出估计的声源位置和距离
%     fprintf('估计的声源位置: (%.8f, %.8f, %.8f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
%     fprintf('声源距离原点的距离: %.8f\n', distance);
%     fprintf('优化残差平方和: %.8f\n', resnorm);
% end


% %%
% function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs)
%     % mic_positions: 麦克风坐标矩阵 (N x 3)
%     % timeDelays: TDOA矩阵 (N x N)
%     % fs: 采样频率 (Hz)
%     
%     speed_of_sound = 343;  % 声速 (m/s)
%     numMics = size(mic_positions, 1);
%     
%     % 初始化方程存储数组
%     equations_func = @(sourceLocation) [
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2); % t12
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3); % t13
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4); % t14
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3); % t23
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4); % t24
%         (norm(sourceLocation - mic_positions(3, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4); % t34
%     ];
%     
%     % 定义目标函数（残差的平方和）
%     objective_func = @(sourceLocation) norm(equations_func(sourceLocation))^2;
%     
%     % 初始猜测的声源位置
%     initial_guess = [0, 0, 0];  % 声源初始位置猜测
%     
%     % 设置位置的约束条件
%     lb = [-Inf, -Inf, 0];  % 下界：第三个值大于0
%     ub = [Inf, Inf, Inf];  % 上界：没有限制
%     
%     % 拟牛顿法（BFGS）优化
%     options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', ...
%         'Display', 'off', 'TolFun', 1e-6, 'TolX', 1e-6, ...
%         'GradObj', 'off', 'Hessian', 'on');
%     
%     % 优化
%     [sourceLocation, resnorm, exitflag, output] = fminunc(objective_func, initial_guess, options);
% 
%     % 计算声源距离原点的距离
%     distance = norm(sourceLocation);
%     
%     % 输出估计的声源位置和距离
%     fprintf('估计的声源位置: (%.8f, %.8f, %.8f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
%     fprintf('声源距离原点的距离: %.8f\n', distance);
%     fprintf('优化残差平方和: %.8f\n', resnorm);
% end





% function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs)
%     speed_of_sound = 343;  % 声速 (m/s)
%     
%     % 方程存储数组
%     equations_func = @(sourceLocation) [
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2); % t12
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3); % t13
%         (norm(sourceLocation - mic_positions(1, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4); % t14
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3); % t23
%         (norm(sourceLocation - mic_positions(2, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4); % t24
%         (norm(sourceLocation - mic_positions(3, :)) - norm(sourceLocation - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4); % t34
%     ];
%     
%     % 初始猜测的声源位置
%     initial_guess = [0, 0, 0];
%     
%     % 设置位置的约束条件
%     lb = [-Inf, -Inf, 0];
%     ub = [Inf, Inf, Inf];
%     
%     % 使用非线性最小二乘法来求解
%     options = optimoptions('lsqnonlin', 'Display', 'iter', 'Algorithm', 'levenberg-marquardt');
%     [sourceLocation, resnorm] = lsqnonlin(equations_func, initial_guess, lb, ub, options);
%     
%     % 计算声源距离原点的距离
%     distance = norm(sourceLocation);
%     
%     % 输出估计的声源位置和距离
%     fprintf('估计的声源位置: (%.8f, %.8f, %.8f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
%     fprintf('声源距离原点的距离: %.8f\n', distance);
%     fprintf('优化残差平方和: %.8f\n', resnorm);
% end
% 