function [ ] = fill_uncertain_values(A, type, opt_cmd )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[n,d] = size(A);
uncertain_values = zeros(n,d);
if strcmp(type, 'GAUSS')
    mu = 0;
    sigma = opt_cmd;
    standard_obj = gmdistribution(mu,sigma,1);
    for i=1:fix(n/5)
        for j=1:d
            uncertain_values(i,j) = random(standard_obj);
        end
    end
elseif strcmp(type, 'ZEROS')
    uncertain_values(1:opt_cmd,:) = -1*A(1:opt_cmd,:);
end
save('uncertain_values.mat','uncertain_values');
end

