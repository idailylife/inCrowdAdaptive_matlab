function [ user_model ] = init_user( alpha, sigma_alpha, beta, size )
%初始化用户模型
%   Detailed explanation goes here
user_model.alpha = cell(size, 1);
for i = 1:size
    % Initialize alpha arrays
    user_model.alpha{i,1} = [];
    user_model.alpha{i,1}(1) = alpha;
end

user_model.sigma_alpha = sigma_alpha * ones(size, 1);
user_model.beta = beta * ones(size, 1);

user_model.right_count = zeros(size, 1); % Trap question result count
user_model.total_count = zeros(size, 1); % Trap question result count

end

