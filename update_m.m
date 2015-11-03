function [ m ] = update_m( i, j, m, answer_count_mat )
%UPDATE_M ���»ش�һ���Ծ���m
%   m_i,j�ǹ��ڴ����⣨i,j���Ļش�𰸵ı�׼����û�лش���ֵ1
%   �ش�𰸣�A>B: 1; A=B: 0.5; A<B: 0;
vec_gt = ones(answer_count_mat.gt(i,j), 1);
vec_lt = zeros(answer_count_mat.lt(i,j), 1);
vec_eq = 0.5 * ones(answer_count_mat.eq(i,j), 1);
vec = [vec_gt; vec_lt; vec_eq];
m(i,j) = std(vec);

end

