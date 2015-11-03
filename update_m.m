function [ m ] = update_m( i, j, m, answer_count_mat )
%UPDATE_M 更新回答一致性矩阵m
%   m_i,j是关于此问题（i,j）的回答答案的标准差，如果没有回答则赋值1
%   回答答案：A>B: 1; A=B: 0.5; A<B: 0;
vec_gt = ones(answer_count_mat.gt(i,j), 1);
vec_lt = zeros(answer_count_mat.lt(i,j), 1);
vec_eq = 0.5 * ones(answer_count_mat.eq(i,j), 1);
vec = [vec_gt; vec_lt; vec_eq];
m(i,j) = std(vec);

end

