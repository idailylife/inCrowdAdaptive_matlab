function [ cmp_matrix ] = get_n_matrix( comparison_records, q_type )
%GET_N_MATRIX ����Ƚϴ˴������󣬾�����(x, y)=x��y���бȽϵĴ���
%   ֻͳ�Ʒ������QoE��
max_id = max(comparison_records(:, 3));
cmp_matrix = zeros(max_id);  % ���ξ���
record_size = length(comparison_records);
for row = 1:record_size
    cmp = comparison_records(row, :);
    if cmp(8) ~= -1
        continue;  % Trap
    elseif cmp(6) ~= 0
        continue;  % QoE
    elseif cmp(5) == 0
        continue;  % unfinished
    elseif cmp(7) ~= q_type
        continue;
    end
    id_a = cmp(3);
    id_b = cmp(4);
    
    cmp_matrix(id_a, id_b) = cmp_matrix(id_a, id_b) + 1;
end

end

