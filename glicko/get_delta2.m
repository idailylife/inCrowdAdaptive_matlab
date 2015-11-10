function [ delta2 ] = get_delta2( F, item_model, id_A, cmp_records, q_type )
%GET_DELTA2 Summary of this function goes here
q2 = (log2(10)/F)^2;

cmp_matrix = get_n_matrix(cmp_records, q_type);

cmp_array = cmp_matrix(id_A,:); % Competitors of A
cmp_array_col = cmp_matrix(:, id_A);
cmp_array = cmp_array + cmp_array_col'; % Add them up!

len = length(cmp_array);
sum = 0;
for id_B = 1:len
    if cmp_array(id_B) == 0
        continue;
    end
    E_A = get_E(item_model.r(id_A), item_model.r(id_B), item_model.sigma2(id_B), F);
    t = cmp_array(id_B) * get_g_sigma2(log(10)/F, item_model.sigma2(id_B))^2 * E_A * (1-E_A);
    sum = sum + t;
end
delta2 = 1 / (q2 * sum);

end

