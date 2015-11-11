function [ user_models ] = update_alpha_sigma( user_models, index )
%UPDATE_ALPHA_SIGMA 更新序号为index的用户能力的不确定度值
%   
user_alpha_list = user_models.alpha{index};  % a CList object
weights = 2.^-(1:length(user_alpha_list));

wt_std = std(user_alpha_list, weights);
user_models.alpha_sigma(index, 1) = wt_std;

end

