function [ item_models ] = update_glicko( item_models, user_ability, cmp_records, cmp_index, F, qtype )
%UPDATE_GLICKO 更新object的模型（得分, 不确定度）
%   Detailed explanation goes here
id0 = cmp(cmp_index, 3);
id1 = cmp(cmp_index, 4);
S_A = cmp(cmp_index, 2); % 1:A wins, 0:B wins, 2:Tie
if S_A == 2
    S_A = 0.5;
end
% Build item to be compatible with the old model
model_A.R = item_models.r(id0);
model_A.sigma2 = item_models.sigma2(id0);
model_B.R = item_models.r(id1);
model_B.sigma2 = item_models.sigma2(id1);

q = log(10)/F;
% Update parameters of model A
g_sigma2_B = get_g_sigma2(q, model_B.sigma2);
E_A = get_E(model_A.R, model_B.R, model_B.sigma2, F);
delta2_A = get_delta2(F, item_models, id0, cmp_records, qtype);
K_A = q / ( 1 / model_A.sigma2 + 1 / delta2_A );
R = model_A.R + user_ability * K_A * g_sigma2_B * ( S_A - E_A ); %;model_A.R + K_A * g_sigma2_B * ( S_A - E_A )
s2 = 1 / ( 1 / model_A.sigma2 + 1 / delta2_A ) ;   % !!!!! TO_BE_MODIFIED (Add user ability)
item_models.r(id0) = R; % Update R of model A
item_models.sigma2(id0) = s2; % Update sigma^2 of model A

% Update parameters of model B
S_B = 1 - S_A;
g_sigma2_A = get_g_sigma2(q, model_A.sigma2);
E_B = get_E(model_B.R, model_A.R, model_A.sigma2, F);
delta2_B = get_delta2(F, item_models, id1, cmp_records, q_type);
K_B = q / ( 1 / model_B.sigma2 + 1 / delta2_B );
R = model_B.R + user_ability * K_B * g_sigma2_A * ( S_B - E_B ); % model_B.R + K_B * g_sigma2_A * ( S_B - E_B);
s2 = 1 / ( 1 / model_B.sigma2 + 1 / delta2_B );    % !!!!! TO_BE_MODIFIED (Add user ability)
item_models.r(id1) = R; % Update R of model B
item_models.sigma2(id1) = s2; % Update sigma^2 of model B

end