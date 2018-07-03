clear all;
clc;
alpha = [1 5 10];
dataset = 'airfoil';
if strcmp(dataset, 'spacega')
    %space-ga;
    cvx_primal_ave = [80.61 19.4 26.5772];
    network_lasso_ave = [80.63 19.3 26.27];
    
    our_method_beta_1e_2_ave = [64.76 18.42 23.28];
    our_method_beta_1e_4_ave = [64.77 19.4 23.77];
    our_method_beta_1e_5_ave = [80.61 19.4 26.57];
    
    vary = 'beta';
    % vary algorithms
    if strcmp(vary,'algo')
        figure();
        data = [our_method_beta_1e_2_ave;cvx_primal_ave; network_lasso_ave];
        base_x = [2 4 6];
        h = bar(base_x, data');
        l={'REG-RG(\beta=10^{-2})', 'PRIMAL-RG', 'NET-LASSO'};
        legend(h,l, 'Location', 'Northeast');
        set(gca, 'XTickLabel',{'\alpha=1','\alpha=5','\alpha=10'});
        set(gca, 'FontSize', 18);
        ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');
        
    elseif strcmp(vary, 'beta')
        figure();
        data = [our_method_beta_1e_2_ave;our_method_beta_1e_4_ave; our_method_beta_1e_5_ave];
        base_x = [2 4 6];
        h = bar(base_x, data');
        l={'REG-RG(\beta=10^{-2})', 'REG-RG(\beta=10^{-4})', 'REG-RG(\beta=10^{-5})'};
        legend(h,l, 'Location', 'Northeast');
        set(gca, 'XTickLabel',{'\alpha=1','\alpha=5','\alpha=10'});
        set(gca, 'FontSize', 18);
        ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');
        
    end
    
elseif strcmp(dataset,'airfoil')
    %airfoil;
    cvx_primal_ave = [531 1727 2866];
    network_lasso_ave = [526 1715 2835];
    
    our_method_beta_1_ave = [530 1693 2832];
    our_method_beta_10_ave = [495 1533 2381];
    our_method_beta_50_ave = [431 703 1225];
    
    vary = 'beta';
    % vary algorithms
    if strcmp(vary,'algo')
        figure();
        data = [our_method_beta_10_ave;cvx_primal_ave; network_lasso_ave];
        base_x = [2 4 6];
        h = bar(base_x, data');
        l={'REG-RG(\beta=1)', 'PRIMAL-RG', 'NET-LASSO'};
        legend(h,l, 'Location', 'Northwest');
        set(gca, 'XTickLabel',{'\alpha=1','\alpha=5','\alpha=10'});
        set(gca, 'FontSize', 18);
        ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');
        
    elseif strcmp(vary, 'beta')
        figure();
        data = [our_method_beta_1_ave;our_method_beta_10_ave; our_method_beta_50_ave];
        base_x = [2 4 6];
        h = bar(base_x, data');
        l={'REG-RG(\beta=1)', 'REG-RG(\beta=10)', 'REG-RG(\beta=50)'};
        legend(h,l, 'Location', 'Northwest');
        set(gca, 'XTickLabel',{'\alpha=1','\alpha=5','\alpha=10'});
        set(gca, 'FontSize', 18);
        ylabel('$|| \mathbf{X}_{\ast} - \mathbf{\tilde{X}}_{\ast} ||^2_F$','Interpreter','LaTex');
        
    end
    
    
    
    
    
end


