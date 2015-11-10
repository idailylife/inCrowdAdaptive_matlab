function [ item_model ] = init_item( r, sigma2, size )
%INIT_ITEM 初始化item模型
%   Detailed explanation goes here

%id直接用矩阵里的行序号算了...
item_model.r = r * ones(size, 1);
item_model.sigma2 = sigma2 * ones(size, 1);

end

