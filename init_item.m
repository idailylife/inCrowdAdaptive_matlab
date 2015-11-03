function [ item_model ] = init_item( r, sigma )
%INIT_ITEM 初始化item模型
%   Detailed explanation goes here

%id直接用矩阵里的行序号算了...
item_model.r = r;
item_model.sigma = sigma;

end

