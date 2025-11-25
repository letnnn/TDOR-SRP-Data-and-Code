% 多起始点
function [sourceLocation, distance] = calculate_locate_source(mic_positions, timeDelays, fs)
    speed_of_sound = 343;
    numMics = size(mic_positions, 1);
    rng(1); % 固定随机种子以保证可重复性
    
    % === PSO参数 ===
    numParticles = 1000;
    numIterations = 100;
    w_max = 0.9; w_min = 0.1;
    c1_max = 2.0; c1_min = 0.1;
    c2_max = 2.0; c2_min = 0.1;
    lb = [-2, -2, 0];
    ub = [2, 2, 2];
    
    % === 多起点次数 ===
    numStarts = 5;   % 例如运行5次不同初始粒子群
    bestGlobalScore = inf;
    bestGlobalPosition = [0, 0, 0];
    
    % === 目标函数 ===
    equations_func = @(x) [
        (norm(x - mic_positions(1, :)) - norm(x - mic_positions(2, :))) - speed_of_sound * timeDelays(1, 2);
        (norm(x - mic_positions(1, :)) - norm(x - mic_positions(3, :))) - speed_of_sound * timeDelays(1, 3);
        (norm(x - mic_positions(1, :)) - norm(x - mic_positions(4, :))) - speed_of_sound * timeDelays(1, 4);
        (norm(x - mic_positions(2, :)) - norm(x - mic_positions(3, :))) - speed_of_sound * timeDelays(2, 3);
        (norm(x - mic_positions(2, :)) - norm(x - mic_positions(4, :))) - speed_of_sound * timeDelays(2, 4);
        (norm(x - mic_positions(3, :)) - norm(x - mic_positions(4, :))) - speed_of_sound * timeDelays(3, 4);
    ];

    for startIdx = 1:numStarts
        fprintf('第 %d 次多起点运行...\n', startIdx);
        
        % === 初始化粒子群 ===
        particles = lb + (ub - lb) .* rand(numParticles, 3);
        velocities = (ub - lb) .* rand(numParticles, 3) * 0.1;
        personalBestPositions = particles;
        personalBestScores = inf(numParticles, 1);
        globalBestPosition = [0, 0, 0];
        globalBestScore = inf;
        
        % === PSO主循环 ===
        for iter = 1:numIterations
            w = w_max - (w_max - w_min) * (iter / numIterations);
            c1 = c1_max - (c1_max - c1_min) * (iter / numIterations);
            c2 = c2_max - (c2_max - c2_min) * (iter / numIterations);
            
            for i = 1:numParticles
                pos = particles(i, :);
                fitness = norm(equations_func(pos));
                if fitness < personalBestScores(i)
                    personalBestScores(i) = fitness;
                    personalBestPositions(i, :) = pos;
                end
                if fitness < globalBestScore
                    globalBestScore = fitness;
                    globalBestPosition = pos;
                end
            end
            
            for i = 1:numParticles
                r1 = rand(1, 3); r2 = rand(1, 3);
                velocities(i, :) = w * velocities(i, :) + ...
                    c1 * r1 .* (personalBestPositions(i, :) - particles(i, :)) + ...
                    c2 * r2 .* (globalBestPosition - particles(i, :));
                particles(i, :) = particles(i, :) + velocities(i, :);
                particles(i, :) = max(particles(i, :), lb);
                particles(i, :) = min(particles(i, :), ub);
            end
        end
        
        % 保存全局最优
        if globalBestScore < bestGlobalScore
            bestGlobalScore = globalBestScore;
            bestGlobalPosition = globalBestPosition;
        end
    end
    
    % === 最终结果 ===
    sourceLocation = bestGlobalPosition;
    distance = norm(sourceLocation);
    
    fprintf('最终估计的声源位置: (%.8f, %.8f, %.8f)\n', sourceLocation(1), sourceLocation(2), sourceLocation(3));
    fprintf('声源距离原点的距离: %.8f\n', distance);
end

