function [ ans_count_model ] = init_answer_count( num_norm )
%INIT_ANSWER_COUNT ��ʼ���ش����ģ��
%   ǿ��Ҫ�󣺾���Ԫ�� i < j (�к�<�к�)
%   .gt: A>B
%   .eq: A=B
%   .lt: A<B
ans_count_model.gt = zeros(num_norm, num_norm);
ans_count_model.eq = zeros(num_norm, num_norm);
ans_count_model.lt = zeros(num_norm, num_norm);


end

