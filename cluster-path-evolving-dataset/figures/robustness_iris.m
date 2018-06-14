clear all;
clc;

%moons; 
alpha = [5 10 50 100];
cvx_primal_2011_ave = [4.2528 8.3861 28.3149 34.95];

our_method_beta_5_ave = [1.6565 3.5189 4.7816 3.3473];

our_method_beta_1_ave = [2.62 4.49 7.8171 6.3708];

SSNAL_ave = [4.2948 8.325 28.2862 34.91];

network_lasso_ave = [4.2569 8.3678 28.189 36.48];

ama_ave = mean([cvx_primal_2011_ave; SSNAL_ave; network_lasso_ave]);

% % vary algorithms
% figure();
% data = [our_method_beta_5_mean;cvx_primal_2011_mean;  SSNAL_mean; network_lasso_mean; ama_mean];
% data_var = [our_method_beta_5_var;cvx_primal_2011_var;  SSNAL_var; network_lasso_var; ama_var];
% base_x = [2 4 6 8];
% h = bar(base_x, data');
% l={'REG-CC(\alpha=5)', 'PRIMAL-CC', 'SSNAL-CC', 'NET-LASSO', 'AMA-CC'};
% legend(h,l, 'Location', 'Northwest');
% set(gca, 'XTickLabel',{'\alpha=5','\alpha=10','\alpha=50','\alpha=100'});
% set(gca, 'FontSize', 18);






our_method_beta_10_ave = [0.7265 1.7036 1 0.4247];
our_method_beta_15_ave = [0.1046 0.095 0.0818 0.0914];
data = [our_method_beta_1_ave;our_method_beta_5_ave;our_method_beta_10_ave;our_method_beta_15_ave];
% vary beta
figure();
base_x = [2 4 6 8];
h = bar(base_x, data');
l={'\beta=1', '\beta=5', '\beta=10', '\beta=15'};
legend(h,l, 'Location', 'Northwest');
set(gca, 'XTickLabel',{'\alpha=5','\alpha=10','\alpha=50','\alpha=100'});
set(gca, 'FontSize', 18);


