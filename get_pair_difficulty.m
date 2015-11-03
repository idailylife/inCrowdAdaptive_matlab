function [ gamma ] = get_pair_difficulty( items, pairs, i, j, C_gamma, C0=100.0 )
%GET_PAIR_DIFFICULTY ����ĳ��C��Ƚ϶Ե��Ѷ�ϵ��
%   items: item_model
%   pairs: pair_model
%   i,j  : item���
if i > j
    t = i;
    i = j;
    j = t;
end
m_ij = pairs(i,j);
r_i = items.r(i);
r_j = items.r(j);
diff_r = r_i - r_j;
sigma_i = items.sigma(i);
sigma_j = items.sigma(j);
gamma = C_gamma * ( exp(-diff_r * diff_r) + (sigma_i+sigma_j)/C0 + m_ij);


end

