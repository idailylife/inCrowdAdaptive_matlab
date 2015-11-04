function [ R_A1, R_B1 ] = btl_update( R_A, R_B, S_A, F, K )
%BTL_UPDATE Summary of this function goes here
%   S_B = 1 - S_A
E_A = 1 / ( 1 + 10^((R_B-R_A)/F));
E_B = 1 / ( 1 + 10^((R_A-R_B)/F));
R_A1 = R_A + K * (S_A - E_A);
R_B1 = R_B + K * (1 - S_A - E_B);

end

