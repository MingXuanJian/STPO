function [Best_score, Best_pos, curve] = STPO(N, Max_iter, lb, ub, dim, fobj)

%% 初始化
X = initialization(N, dim, ub, lb);

%% 初始适应度
fitness = zeros(1, N);
for j = 1:N
    Flag4ub = X(j,:) > ub;
    Flag4lb = X(j,:) < lb;
    X(j,:) = (X(j,:) .* (~(Flag4ub + Flag4lb))) + ub .* Flag4ub + lb .* Flag4lb;
    fitness(j) = fobj(X(j, :));
end

[GBestF, index] = min(fitness);
GBestX = X(index, :);

curve = zeros(1, Max_iter);
X_new = X;
fitness_new = zeros(1, N);   %  预分配，避免动态扩容

%% 迭代
for i = 1:Max_iter
    alpha = rand(1) / 5; %#ok<NASGU>  % 变量保留，不影响算法
    sita = rand(1) * pi;

    for j = 1:N
        St = randi([1, 4]);

        if St == 1
            X_new(j, :) = (X(j, :) - GBestX) .* Levy(dim) + rand(1) * mean(X(j, :)) * (1 - i / Max_iter)^(2 * i / Max_iter);

        elseif St == 2
            if fitness(j) > GBestF
                X_new(j,:) = GBestX + randn(1, dim) .* abs(X(j,:) - GBestX);
            else
                X_new(j, :) = X(j, :) + GBestX .* Levy(dim) + randn() * (1 - i / Max_iter) * ones(1, dim);
            end

        elseif St == 3
            random_index = randi([1, N]);
            while random_index == j
                random_index = randi([1, N]);
            end
            X_new(j, :) = (X(j, :) + X(random_index, :)) / 2;

        else
            [fmax, IDX] = max(fitness);
            worse = X(IDX,:);
            if fitness(j) > GBestF
                X_new(j,:) = GBestX + randn(1, dim) .* abs(X(j,:) - GBestX);
            else
                if rand > 0.5
                    X_new(j,:) = X(j,:) + (2 * rand(1) - 1) * abs(X(j,:) - worse) / (fitness(j) - fmax + 1e-50);
                else
                    X_new(j, :) = X(j, :) + rand() * cos((pi * i) / (2 * Max_iter)) * (GBestX - X(j, :)) ...
                        - cos(sita) * (i / Max_iter)^(2 / Max_iter) * (X(j, :) - GBestX);
                end
            end
        end

        % 边界
        Flag4ub = X_new(j,:) > ub;
        Flag4lb = X_new(j,:) < lb;
        X_new(j,:) = (X_new(j,:) .* (~(Flag4ub + Flag4lb))) + ub .* Flag4ub + lb .* Flag4lb;

        % 更新
        fitness_new(j) = fobj(X_new(j, :));
        if fitness_new(j) < fitness(j)
            fitness(j) = fitness_new(j);
            X(j,:) = X_new(j,:);

            if fitness(j) < GBestF
                GBestF = fitness(j);
                GBestX = X(j, :);
            end
        end
    end

    curve(i) = GBestF;
end

Best_pos = GBestX;
Best_score = GBestF;

end

%% Levy
function o = Levy(d)
beta = 1.5;
sigma = (gamma(1 + beta) * sin(pi * beta / 2) / (gamma((1 + beta) / 2) * beta * 2^((beta - 1) / 2)))^(1 / beta);
u = randn(1, d) * sigma;
v = randn(1, d);
o = u ./ abs(v).^(1 / beta);
end

