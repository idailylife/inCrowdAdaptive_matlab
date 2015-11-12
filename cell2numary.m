function [ num_ary ] = cell2numary( cell_ary )
%CELL2NUMARY Turns cell array (1 * N cell) to number array
cell_n = length(cell_ary);
num_ary = zeros(1, cell_n);
for i = 1:cell_n
    num_ary(1,i) = str2num(cell_ary{1,i});
end

end

