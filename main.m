function [] = main( config_args, db_records )
%Read config arguments and start a new session of test
%   config_args.nOfQSet: 每组的题量
%              .th_A   : 问题比例分配阈值A
%              .th_B   : 问题比例分配阈值B
%              .m0     : 一致性因子初始值m0
%              .sigma_A: A类题不确定度常量
%              .C_gamma: 获取问题难度值公式的常量
%              .C_B    : 参与者评价可信度公式常量
%              .norm_n : 普通候选项个数
%              .gs_num : gold-standard题目的个数
%              .c_or_u : 0-只统计创新性，1-只统计实用性
%
%   db_records.version : 数据库记录版本
%             .hit     : hit记录
%             .cmp     : cmp记录
%             .gs      : gold-standard问题集

ans_count_model = init_answer_count(config_args.norm_n);
item_models = init_item(100, 100, config_args.norm_n);
pair_models = init_pair(config_args.norm_n);

hits = db_records.hit;
user_num = length(hits);
vec100 = 100 * ones(user_num, 1);
user_models = init_user(100, 100, 0, user_num);

for row = 1:user_num
    % Traverse throughout all HIT records
    cmp_ids_str = hits{row, 8}; % String of ids of comparisons
    cmp_ids = loadjson(cmp_ids_str);
    min_id = min(cmp_ids);
    min_index = find(db_records.cmp(:,1) == min_id);
    for cmp_row = min_index:min_index + length(cmp_ids) - 1
        % Traverse throughout all comparisons in this HIT record
        cmp = db_records.cmp(cmp_row, :);
        if cmp(7) ~= config_args.c_or_u
            continue;
        end
        if cmp(8) == -1
            %Not a type- question
            if cmp(6) == 1
                %Type-A: Gold-standard
                gold_answer = get_gold_answer(cmp, db_records.gs);
                if gold_answer == cmp(2)
                    % Regard as the user WIN the competition
                    
                else
                    % Lose
                end
            else
                %Type-C:Normal
            end
        else
            %Type-B: Trap
            ;
    end
end


end

