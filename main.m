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
%
%   db_records.version : 数据库记录版本
%             .hit     : hit记录
%             .cmp     : cmp记录
%             .gs      : gold-standard问题集

ans_count_model = init_answer_count(config_args.norm_n);
vec100 = 100 * ones(config_args.norm_n, 1);
item_models = init_item(vec100, vec100);
pair_models = init_pair(config_args.norm_n);




end

