function [ item_model ] = init_item( r, sigma2, size )
%INIT_ITEM ��ʼ��itemģ��
%   Detailed explanation goes here

%idֱ���þ���������������...
item_model.r = r * ones(size, 1);
item_model.sigma2 = sigma2 * ones(size, 1);

end

