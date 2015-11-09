function [] = main( config_args, db_records )
%Read config arguments and start a new session of test
%   config_args.nOfQSet: ÿ�������
%              .th_A   : �������������ֵA
%              .th_B   : �������������ֵB
%              .m0     : һ�������ӳ�ʼֵm0
%              .sigma_A: A���ⲻȷ���ȳ���
%              .C_gamma: ��ȡ�����Ѷ�ֵ��ʽ�ĳ���
%              .C_B    : ���������ۿ��Ŷȹ�ʽ����
%              .norm_n : ��ͨ��ѡ�����
%              .gs_num : gold-standard��Ŀ�ĸ���
%              .c_or_u : 0-ֻͳ�ƴ����ԣ�1-ֻͳ��ʵ����
%
%   db_records.version : ���ݿ��¼�汾
%             .hit     : hit��¼
%             .cmp     : cmp��¼
%             .gs      : gold-standard���⼯

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
                F = 400.0;
                K = 32;
                gs_R = 100.0; %����ֻ��g-s����һ�����������Ѷ�ֵ���Ժ���Ҫ�ģ�
                if gold_answer == cmp(2)
                    % Regard as the user WIN the competition
                    S_A = 1;
                else
                    % Lose
                    S_A = 0;
                end
                % Update alpha
                R_A = user_models.alpha{row,1};
                R_A = R_A.back(); % Rear value
                [R_A, ~] = elo_update(R_A, gs_R, S_A, F, K);
                user_models.alpha{row}.pushtofront(R_A); % ���µ�����ǰ��
                % Re-calculate sigma_alpha
                update_alpha_sigma(user_models, row);
                
            else
                %Type-C:Normal
                
                
            end
        else
            %Type-B: Trap
            orig_id = cmp(8);
            orig_index = find(db_records.cmp(:,1) == orig_id);
            orig_cmp_answer  = db_records.cmp(orig_index, 2);
            if orig_cmp_answer == cmp(2)
                % different answer
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

