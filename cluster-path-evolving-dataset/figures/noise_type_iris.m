clear all;
clc;

%iris; 
alpha = 5;
sparse_noise = [1.29 2.7173 3.3593];

uniform_noise = [2.5889 3.5402 4.04];

mixed_noise = [2.627 3.498 4.0259];

data = [sparse_noise; uniform_noise; mixed_noise];
% vary beta
figure();
base_x = [2 4 6];
h = bar(base_x, data);
l={'s=1', 's=2', 's=\infty'};
legend(h,l, 'Location', 'Northwest');
set(gca, 'XTickLabel',{'Sparse change','Dense change','Mixed change'});
set(gca, 'FontSize', 18);
ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');


