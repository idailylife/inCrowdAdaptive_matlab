function [ user_models ] = update_alpha_sigma( user_models, index )
%UPDATE_ALPHA_SIGMA �������Ϊindex���û������Ĳ�ȷ����ֵ
%   
user_alpha_list = user_models.alpha{index};  % a CList object
weights = 2.^-(1:length(user_alpha_list));

wt_std = std(user_alpha_list, weights);
user_models.alpha_sigma(index, 1) = wt_std;

end

