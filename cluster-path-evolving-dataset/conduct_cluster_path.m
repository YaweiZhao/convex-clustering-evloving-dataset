function [s_hyp] = conduct_cluster_path( s_hyp )

n = s_hyp.n;
d = s_hyp.d;
A = s_hyp.A;
num_level = s_hyp.num_level;

%begin solving
if d>2
    [coeff,score,latent] = pca(A);
end

X=[];
for i=1:num_level
    
    s_hyp.alpha = (s_hyp.step + s_hyp.step_increase)*s_hyp.alpha;
    s_hyp = unware_regularized_convex_clustering(s_hyp);
    
    %centering X3 in order to draw
    X_temp = s_hyp.X- repmat(mean(s_hyp.X),n,1);
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


if d>2
    s_hyp.data4draw = score(:,1:2);
    draw_clusterpath(s_hyp);
elseif d==2
        s_hyp.data4draw = A;
     draw_clusterpath(s_hyp);
end


end

