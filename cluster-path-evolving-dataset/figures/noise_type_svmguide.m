clear all;
clc;

%svm-guide; 
alpha = 5;
sparse_noise = [18.448 40.72 41.1];

uniform_noise = [40.94 44.6 50.26];

mixed_noise = [38.64 42.49 48.15];

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


