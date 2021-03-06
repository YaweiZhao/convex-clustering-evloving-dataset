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
    
    s_hyp.alpha = (s_hyp.step + s_hyp.step_increase)*alpha;
    
    if strcmp(s_hyp.ALGO,'CVX-PRIMAL-2011')
          s_hyp  = convex_clustering_cvx_primal( s_hyp );
    elseif strcmp(s_hyp.ALGO,'our_method')
        s_hyp = unware_regularized_convex_clustering(s_hyp);
    elseif strcmp(s_hyp.ALGO,'NETWORK_LASSO')
        s_hyp = network_lasso(s_hyp);
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


% figure;
% 
% if d>2
%     s_hyp.data4draw = score(:,1:2);
%     draw_clusterpath(s_hyp);
% elseif d==2
%         s_hyp.data4draw = A;
%      draw_clusterpath(s_hyp);
% end


end

