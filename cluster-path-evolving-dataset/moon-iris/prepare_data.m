function [s_hyp] = prepare_data()
s_hyp.fn_name = 'iris2.txt';
A_temp = load(s_hyp.fn_name);
[n,d] = size(A_temp);
A_temp = rand_perm_data(A_temp);%whether to permute data randomly
true_label = A_temp(:,d);
s_hyp.true_label = true_label;
s_hyp.A = A_temp(:,1:d-1) - repmat(mean(A_temp(:,1:d-1)),n,1);
%s_hyp.A = transpose(mapstd(transpose(A_temp(:,1:d-1))));

s_hyp.n = n;
s_hyp.d = d-1;
end


function[A_temp] = rand_perm_data(A_temp)
[n,~] = size(A_temp);
index = randperm(n);
A_temp = A_temp(index,:);
end

























