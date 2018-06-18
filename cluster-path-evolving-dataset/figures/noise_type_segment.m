clear all;
clc;

%segment; 
alpha = 5;
sparse_noise = [8.72 11.52 11.81];

uniform_noise = [12.4 12.37 12.36];

mixed_noise = [19.07 19.05 19.04];

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


