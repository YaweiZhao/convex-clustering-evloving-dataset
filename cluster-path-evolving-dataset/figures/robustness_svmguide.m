clear all;
clc;

%moons; 
alpha = [5 10 50 100];
cvx_primal_2011_ave = [39.84 65.4 37 23];

our_method_beta_5_ave = [38 64.6 34 21];

our_method_beta_10_ave = [36 64 31.5 20];

our_method_beta_15_ave = [35 64 28 18.8];

our_method_beta_20_ave = [34 64 26 17];

our_method_beta_1_ave = [39.45 64.6 36 22.8];

SSNAL_ave = [40 65 37 23.2];

%network_lasso_ave = [];

ama_ave = mean([cvx_primal_2011_ave; SSNAL_ave]);

% % vary algorithms
% figure();
% data = [our_method_beta_5_ave;cvx_primal_2011_ave;  SSNAL_ave; ama_ave];
% base_x = [2 4 6 8];
% h = bar(base_x, data');
% l={'REG-CC(\alpha=5)', 'PRIMAL-CC', 'SSNAL-CC',  'AMA-CC'};
% legend(h,l, 'Location', 'Northeast');
% set(gca, 'XTickLabel',{'\alpha=5','\alpha=10','\alpha=50','\alpha=100'});
% set(gca, 'FontSize', 18);
% ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');





data = [our_method_beta_1_ave;our_method_beta_5_ave;our_method_beta_10_ave;our_method_beta_15_ave];
% vary beta
figure();
base_x = [2 4 6 8];
h = bar(base_x, data');
l={'\beta=1', '\beta=5', '\beta=10', '\beta=15'};
legend(h,l, 'Location', 'Northeast');
set(gca, 'XTickLabel',{'\alpha=5','\alpha=10','\alpha=50','\alpha=100'});
set(gca, 'FontSize', 18);
ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');


