clear all;
clc;

%moons; 
alpha = 5;
sparse_noise = [2.5 10 11.8];

uniform_noise = [3 10.68 12.3];

mixed_noise = [5 11.22 12.8];

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


