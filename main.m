function [] = main( config_args, db_records )
%Read config arguments and start a new session of test
%   config_args.
%              .m0     : 一致性因子初始值m0
%              .sigma_A: A类题不确定度常量
%              .C_gamma: 获取问题难度值公式的常量
%              .C_B    : 参与者评价可信度公式常量
%              .norm_n : 普通候选项个数 （河姆渡杯是551）
%              .c_or_u : 0-只统计创新性，1-只统计实用性
%              .F      : Glicko模型参数F
%
%   db_records.version : 数据库记录版本
%             .hit     : hit记录
%             .cmp     : cmp记录
%             .gs      : gold-standard问题集

ans_count_model = init_answer_count(config_args.norm_n);
item_models = init_item(100, 100, config_args.norm_n);
pair_models = init_pair(config_args.norm_n, config_args.m0);

hits = db_records.hit;
user_num = length(hits);
user_models = init_user(100, 100, 0.5, user_num);

for row = 1:user_num
    % Traverse throughout all HIT records
    cmp_ids_str = hits{row, 8}; % String of ids of comparisons
    cmp_ids = cell2numary( loadjson(cmp_ids_str) );
    
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
                F = config_args.F;
                K = 32;
                gs_R = 100.0; %这里只对g-s题用一个常数定义难度值，以后需要改！
                if gold_answer == cmp(2)
                    % Regard as the user WIN the competition
                    S_A = 1;
                else
                    % Lose
                    S_A = 0;
                end
                % Update alpha
                R_A = user_models.alpha{row,1};
                R_A = R_A(1); % Rear value
                [R_A, ~] = elo_update(R_A, gs_R, S_A, F, K);
                user_models.alpha{row} = [R_A, user_models.alpha{row}]; % 最新的在最前面
                % Re-calculate sigma_alpha
                user_models = update_alpha_sigma(user_models, row);
                
            else
                %Type-C:Normal
                %Update pair model (`m` value)
                answer  = cmp(2);
                id0 = cmp(3);
                id1 = cmp(4);
                pair_models = update_pair_difficulty(id0, id1, answer, ans_count_model, pair_models);                
                
                %Get user ability
                alpha = user_models.alpha{row,1}(1);
                beta = user_models.beta(row,1);
                gamma = get_pair_difficulty(item_models, pair_models, id0, id1, config_args.C_gamma); %pair_models(id0, id1);
                user_ability = get_user_ability(alpha, beta, gamma, config_args.C_B);
                
                %Update Glicko model w/ user ability
                item_models = update_glicko(item_models, user_ability, db_records.cmp, cmp_row, config_args.F, config_args.c_or_u);
                
            end
        else
            %Type-B: Trap
            orig_id = cmp(8);
            orig_index = find(db_records.cmp(:,1) == orig_id);
            orig_cmp_answer  = db_records.cmp(orig_index, 2);
            if orig_cmp_answer == cmp(2)
                % The same answer
                user_models.right_count(row) = user_models.right_count(row) + 1;
            end
            user_models.total_count(row) = user_models.total_count(row) + 1;
            r_count = user_models.right_count(row);
            t_count = user_models.total_count(row);
            w_mark = get_wilson(r_count, t_count);
            user_models.beta(row) = w_mark;
        end
    end
end


end

