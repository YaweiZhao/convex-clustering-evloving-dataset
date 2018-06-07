function [A_raw,A, true_label] = prepare_data(fn_A,type)
A_temp = load(fn_A);
[n,d] = size(A_temp);
true_label = A_temp(:,d);
%rand_perm_data(A_temp);%whether to permute data randomly
A = A_temp(:,1:d-1) - repmat(mean(A_temp(:,1:d-1)),n,1);
%A = standardised_data(A,true_label);
A_raw = A_temp(:,1:d-1) - repmat(mean(A_temp(:,1:d-1)),n,1);

%add noise
if strcmp(type, 'NOISE')
    %fill_uncertain_values(A, 'GAUSS', 1 );%the third param is the value of the sigma
    uncertain_values_temp = load('uncertain_values.mat');
    uncertain_values = uncertain_values_temp.uncertain_values;
    A = A + uncertain_values; %add noise
end


end

function[] = rand_perm_data(A_temp)
[n,d] = size(A_temp);
index = randperm(n);
A_temp = A_temp(index,:);
save('haberman2.txt', 'A_temp','-ascii');
end

function[A] = standardised_data(A,true_label)
A1 = mapstd(A');
A = [A1' true_label];
end























