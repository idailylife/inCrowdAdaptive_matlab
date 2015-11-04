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

