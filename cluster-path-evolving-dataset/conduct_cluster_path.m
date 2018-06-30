function [s_hyp] = conduct_cluster_path( s_hyp )

n = s_hyp.n;
d = s_hyp.d;
A = s_hyp.A;
num_level = s_hyp.num_level;

%begin solving
if d>2
    [coeff,score,~] = pca(A);
end

X=[];
alpha = s_hyp.alpha;
for i=1:num_level
    alpha = i*alpha;
    s_hyp.alpha = alpha;
    
    if strcmp(s_hyp.ALGO,'CVX-PRIMAL') && strcmp(s_hyp.TASK_TYPE,'ridge_regression')
          s_hyp  = ridge_regression_cvx_primal( s_hyp );
    elseif strcmp(s_hyp.ALGO,'our_method')&& strcmp(s_hyp.TASK_TYPE,'ridge_regression')
        s_hyp = unware_regularized_ridge_regression(s_hyp);
    elseif strcmp(s_hyp.ALGO,'NETWORK_LASSO')&& strcmp(s_hyp.TASK_TYPE,'ridge_regression')
        s_hyp = ridge_regression_network_lasso(s_hyp);
    end

    %centering X3 in order to draw
    X_temp = s_hyp.X;
    X = [X; X_temp];
    
    if i==num_level
        if d>2
            centers = X*coeff(:,1:2);
        elseif d==2
            centers = X;
        end
        s_hyp.centers = centers;
    end
        
    
    %draw result
    %draw_pixel_clusters( s_hyp )

end

% data_for_draw = A;
% centers = s_hyp.centers;
% true_label = s_hyp.true_label;
% save('./svmguides-pendigits/data_for_draw_svmguide.mat','data_for_draw');
% save('./svmguides-pendigits/centers_svmguide.mat', 'centers');
% save('./svmguides-pendigits/true_label_svmguide.mat', 'true_label');

% figure;
% 
% if d>2
%     s_hyp.data4draw = score(:,1:2);
%     draw_clusterpath(s_hyp);
% elseif d==2
%         s_hyp.data4draw = A;
%         draw_clusterpath(s_hyp);
% 
% end
% 

end

