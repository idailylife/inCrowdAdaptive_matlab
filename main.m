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
%
%   db_records.version : ���ݿ��¼�汾
%             .hit     : hit��¼
%             .cmp     : cmp��¼
%             .gs      : gold-standard���⼯

ans_count_model = init_answer_count(config_args.norm_n);
vec100 = 100 * ones(config_args.norm_n, 1);
item_models = init_item(vec100, vec100);
pair_models = init_pair(config_args.norm_n);




end

