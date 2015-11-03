function [ pair_models ] = init_pair( num_item, m0 )
%INIT_PAIR ³õÊ¼»¯normal questionµÄ¾ØÕó
%   Detailed explanation goes here
pair_models = zeros(num_item, num_item);
for i=1:num_item
    for j=1:i
        pair_models(i,j) = m0;
    end
end

end

