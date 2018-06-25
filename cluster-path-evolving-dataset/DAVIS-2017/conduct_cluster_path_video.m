function [s_hyp] = conduct_cluster_path_video( s_hyp )

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
    s_hyp = convex_clustering_cvx_primal_video( s_hyp );
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

figure;

if d>2
    s_hyp.data4draw = score(:,1:2);
    draw_clusterpath_video(s_hyp);
elseif d==2
        s_hyp.data4draw = A;
        draw_clusterpath_video(s_hyp);

end


end

