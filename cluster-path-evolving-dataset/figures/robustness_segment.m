clear all;
clc;

%moons; 
alpha = [5 10 50 100];
cvx_primal_2011_ave = [11.4279 13.6896 8.5412 5.4422];

our_method_beta_05_ave = [11.2933 13.4644 8.3342 5.3312];

our_method_beta_01_ave = [11.3993 13.6433 8.4984 5.4177];

our_method_beta_5_ave = [10.5119 11.9594 7.2989 5.14];

our_method_beta_1_ave = [11.1793 13.2552 8.3342 5.2458];

SSNAL_ave = [11.4279 14.39 8.5412 5.4422];

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





data = [our_method_beta_01_ave;our_method_beta_05_ave; our_method_beta_1_ave;our_method_beta_5_ave];
% vary beta
figure();
base_x = [2 4 6 8];
h = bar(base_x, data');
l={'\beta=0.1', '\beta=0.5', '\beta=1', '\beta=5'};
legend(h,l, 'Location', 'Northeast');
set(gca, 'XTickLabel',{'\alpha=5','\alpha=10','\alpha=50','\alpha=100'});
set(gca, 'FontSize', 18);
ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');


