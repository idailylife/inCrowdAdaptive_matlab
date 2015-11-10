function [ pair_models ] = update_pair_difficulty( id0, id1, answer, ans_count_model, pair_models )
%UPDATE_PAIR_DIFFICULTY Summary of this function goes here
%   Detailed explanation goes here
if id0 > id1
    t = id1;
    id1 = id0;
    id0 = t;
    %Switch answer
    if answer < 2
        answer = 1 - answer;
    end
end
switch answer
    case 0 % B > A, lt
        ans_count_model.lt(id0, id1) = ans_count_model.lt(id0, id1) + 1;
    case 1 % A > b, gt
        ans_count_model.gt(id0, id1) = ans_count_model.gt(id0, id1) + 1;
    case 2 % eq
        ans_count_model.eq(id0, id1) = ans_count_model.eq(id0, id1) + 1;
    otherwise
        warning('bad compare result');
end
% expand answers to array
ary = zeros( ans_count_model.lt(id0, id1), 1);
ary = [ary; ones(ans_count_model.gt(id0, id1), 1)];
ary = [ary; 0.5 * ones(ans_count_model.eq(id0, id1), 1)];
std_ary = std(ary);
pair_models(id0, id1) = std_ary;

end

