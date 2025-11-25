% 替代求解器 实验室对比试验
function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs, solver)
    % mic_positions: 麦克风坐标矩阵 (N x 3)
    % timeDelays: TDOA矩阵 (N x N)
    % fs: 采样频率 (Hz)
    % solver: 求解器类型 ('LM', 'NM', 'DE', 'SA')

    speed_of_sound = 343;  % 声速 (m/s)
    rng(1);                % 固定随机种子保证可重复性

    % === 定义目标函数 ===
    equations_func = @(x) [
        (norm(x - mic_positions(1, :)) - norm(x - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2);
        (norm(x - mic_positions(1, :)) - norm(x - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3);
        (norm(x - mic_positions(1, :)) - norm(x - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4);
        (norm(x - mic_positions(2, :)) - norm(x - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3);
        (norm(x - mic_positions(2, :)) - norm(x - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4);
        (norm(x - mic_positions(3, :)) - norm(x - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4);
    ];

    % 初始猜测点
    x0 = [0, 0, 1];  % 可根据实验场景调整
    lb = [-2, -2, 0];
    ub = [2, 2, 2];

    % === 选择求解器 ===
    switch upper(solver)
        case 'LM'  % Levenberg–Marquardt
            options = optimoptions('lsqnonlin', 'Display', 'iter', 'Algorithm', 'levenberg-marquardt');
            sourceLocation = lsqnonlin(equations_func, x0, lb, ub, options);

        case 'NM'  % Nelder–Mead
            options = optimset('Display', 'iter', 'MaxIter', 1000);
            objFunc = @(x) norm(equations_func(x));
            sourceLocation = fminsearch(objFunc, x0, options);

        case 'DE'  % Differential Evolution (需要 Global Optimization Toolbox)
            objFunc = @(x) norm(equations_func(x));
            opts = optimoptions('ga', 'Display', 'iter', 'PopulationSize', 200, 'MaxGenerations', 100);
            nvars = 3;
            sourceLocation = ga(objFunc, nvars, [], [], [], [], lb, ub, [], opts);

        case 'SA'  % Simulated Annealing (需要 Global Optimization Toolbox)
            objFunc = @(x) norm(equations_func(x));
            opts = optimoptions('simulannealbnd', 'Display', 'iter', 'MaxIterations', 200);
            sourceLocation = simulannealbnd(objFunc, x0, lb, ub, opts);

        otherwise
            error('Unsupported solver. Use ''LM'', ''NM'', ''DE'', or ''SA''.');
    end

    % === 计算声源距离 ===
    distance = norm(sourceLocation);

    % === 输出结果 ===
    fprintf('求解器: %s\n', solver);
    fprintf('估计的声源位置: (%.6f, %.6f, %.6f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
    fprintf('声源距离原点的距离: %.6f m\n', distance);
end
