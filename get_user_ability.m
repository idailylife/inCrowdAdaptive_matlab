function [ Beta ] = get_user_ability( alpha, beta, gamma, C_B )
%GET_USER_ABILITY 参与者评价可信度
%   Detailed explanation goes here
Beta = C_B * alpha * beta / gamma;

end

