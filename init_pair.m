function [ pair_models ] = init_pair( num_item, m0 )
%INIT_PAIR 初始化normal question的矩阵，存储值为
%                           “所有关于此问题的回答答案的标准差”
%   Detailed explanation goes here
pair_models = zeros(num_item, num_item);
for i=1:num_item
    for j=1:i
        pair_models(i,j) = m0;
    end
end

end

