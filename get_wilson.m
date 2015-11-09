function [ wilson_floor ] = get_wilson( right_count, total_count, z=1.96 )
%GET_WILSON 威尔逊区间的下限值
%   Detailed explanation goes here
if total_count <= 0
    warning('TOTAL_COUNT <= 0');
end
n = total_count;
p = right_count / total_count;
in_sqrt = sqrt(p * (1-p) / n + z^2/(4*n^2));
wilson_floor = (p + z^2/(2*n) - z*in_sqrt) / (1+ (1/n)*z^2);

end

