function [ num ] = cell2num( cell )
%CELL2NUM Turns 1x1 cell to num value

mat = cell2mat(cell);
num = mat(1,1);

end

