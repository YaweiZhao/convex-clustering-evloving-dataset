clear all;
clc;

%moons; 
alpha = [5 10 50 100];
cvx_primal_2011_max = [4.2589  8.4057 28.3339 34.97];
cvx_primal_2011_ave = [4.2528 8.3861 28.3149 34.95];
cvx_primal_2011_min = [4.2433 8.3836 28.2711 34.863];
cvx_primal_2011_var = var([cvx_primal_2011_max;cvx_primal_2011_ave;cvx_primal_2011_min]);
cvx_primal_2011_mean = mean([cvx_primal_2011_max;cvx_primal_2011_ave;cvx_primal_2011_min]);

our_method_beta_5_max = [2.8487 6.4121 24.193 32.033];
our_method_beta_5_ave = [2.8480 6.3973 24.192 32.0278];
our_method_beta_5_min = [2.8415 6.3855 24.1648 32.0128];
our_method_beta_5_var = var([our_method_beta_5_max;our_method_beta_5_ave;our_method_beta_5_min]);
our_method_beta_5_mean = mean([our_method_beta_5_max;our_method_beta_5_ave;our_method_beta_5_min]);

our_method_beta_1_max = [3.8538 7.8674 27.436 34.33];
our_method_beta_1_ave = [3.8286 7.8305 27.4284 34.28];
our_method_beta_1_min = [3.8036 7.82 27.4261 34.278];
our_method_beta_1_var = var([our_method_beta_1_max;our_method_beta_1_ave;our_method_beta_1_min]);
our_method_beta_1_mean = mean([our_method_beta_1_max;our_method_beta_1_ave;our_method_beta_1_min]);


SSNAL_max = [4.313 8.3763 28.2962 34.95];
SSNAL_ave = [4.2948 8.325 28.2862 34.91];
SSNAL_min = [4.2547 8.32 28.25 34.8];
SSNAL_var = var([SSNAL_max;SSNAL_ave;SSNAL_min]);
SSNAL_mean = mean([SSNAL_max;SSNAL_ave;SSNAL_min]);

network_lasso_max = [4.2991 8.37 28.2 36.52];
network_lasso_ave = [4.2569 8.3678 28.189 36.48];
network_lasso_min = [4.2528 8.328 28.1518 36.3];
network_lasso_var = var([network_lasso_max;network_lasso_ave;network_lasso_min]);
network_lasso_mean = mean([network_lasso_max;network_lasso_ave;network_lasso_min]);


ama_max = mean([cvx_primal_2011_max; SSNAL_max; network_lasso_max]);
ama_min = mean([cvx_primal_2011_min; SSNAL_min; network_lasso_min]);
ama_ave = mean([cvx_primal_2011_ave; SSNAL_ave; network_lasso_ave]);
ama_var = var([ama_max;ama_ave;ama_min]);
ama_mean = mean([ama_max;ama_ave;ama_min]);

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






our_method_beta_5_ave = our_method_beta_5_mean;
our_method_beta_1_ave = our_method_beta_1_mean;
our_method_beta_10_ave = [2.289 4.9817 20.52 29.76];
our_method_beta_15_ave = [2 3.76 17.2 27.4];
our_method_beta_20_ave = [1.79 3.27 13.5 25.9];
data = [our_method_beta_1_ave;our_method_beta_5_ave;our_method_beta_10_ave;our_method_beta_15_ave;our_method_beta_20_ave];
% vary beta
figure();
base_x = [2 4 6 8];
h = bar(base_x, data');
l={'\beta=1', '\beta=5', '\beta=10', '\beta=15', '\beta=20'};
legend(h,l, 'Location', 'Northwest');
set(gca, 'XTickLabel',{'\alpha=5','\alpha=10','\alpha=50','\alpha=100'});
set(gca, 'FontSize', 18);


