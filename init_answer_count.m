function [ ans_count_model ] = init_answer_count( num_norm )
%INIT_ANSWER_COUNT 初始化回答计数模型
%   强制要求：矩阵元素 i < j (行号<列号)
%   .gt: A>B
%   .eq: A=B
%   .lt: A<B
ans_count_model.gt = zeros(num_norm, num_norm);
ans_count_model.eq = zeros(num_norm, num_norm);
ans_count_model.lt = zeros(num_norm, num_norm);


end

