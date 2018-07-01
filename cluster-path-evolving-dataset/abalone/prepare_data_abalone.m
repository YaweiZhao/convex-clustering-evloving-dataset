function [s_hyp] = prepare_data_abalone()
%NoN = 2, n = n/3
s_hyp.fn_name = 'abalone.mat';
A_temp = load(s_hyp.fn_name);
A_temp = A_temp.data;

%A_temp = rand_perm_data(A_temp);%whether to permute data randomly
%true_label = A_temp(:,1);
A_temp = rand_perm_data(A_temp);%whether to permute data randomly
%A_temp = A_temp(1:200,:);
true_label = A_temp(:,1);

[n,d] = size(A_temp);
s_hyp.true_label = true_label;
A_temp = transpose(mapstd(transpose(A_temp(:,2:d))));
%A = A_temp - mean(A_temp);
[U,S,V] = svd(A_temp, 'econ');
num_primal_component = 2;
A = U(:,1:num_primal_component) * S(1:num_primal_component,1:num_primal_component) * V(1:num_primal_component,1:num_primal_component)';
n = fix(n);

s_hyp.A = A(1:n,:);%choose a subset of A
s_hyp.n = n;
s_hyp.d = num_primal_component;
%scatter(A(:,1), A(:,2));
end


function[A_temp] = rand_perm_data(A_temp)
[n,~] = size(A_temp);
index = randperm(n);
A_temp = A_temp(index,:);
end

























