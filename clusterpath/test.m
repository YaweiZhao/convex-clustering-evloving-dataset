clear;
[A_raw, A_std, true_label] = prepare_data( 'iris2.txt','NO NOISE');
[n,d] = size(A_std);                                                                                              
[edge_matrix, weight_matrix ] = build_network(A_std, 'NEIGHBOURS', 10);
rho=1;
p=2;         %p norm
step = 1;
step_increase = 0.1;
alpha =5;
X1 = [];
C1 = [];
X2 = [];
C2 = [];
X3 = [];
C3 = [];
X4 = [];
C4 = [];
if d>2
    [coeff,score,latent] = pca(A_std);
end       
num_level = 1;
tic;
for i=1:num_level
    %basic  ADMM
%     step = step + step_increase;
%     alpha = alpha*step;
%     [Q,m,sum_triangles] = build_Q('TRIANGLE LASSO', edge_matrix, weight_matrix,  alpha, n);
%     %standard ADMM
%     [ X1_temp, t1] = standard_admm(A_std, Q,n,d,m,rho,p);
%     %centering X3 in order to draw
%     X1_temp = X1_temp- repmat(mean(X1_temp),n,1);
%     X1 = [X1; X1_temp];
%     [cluster_ids1_temp, num_clusters_tri_admm, acc1] = evaluate_clustering_result(X1_temp, true_label, n);
%     C = [C1; cluster_ids1_temp];
%     time1 = t1;
%     if i==num_level
%         if d>2
%             centers = X1*coeff(:,1:2);
%         else if d==2
%                 centers = X1;
%             end
%         end
%     end
    %our ADMM
%     step = step + step_increase;
%     alpha = alpha*step;
%     [Q,m,sum_triangles] = build_Q('TRIANGLE LASSO', edge_matrix, weight_matrix,  alpha, n);
%     X2_temp = our_admm(A_std, Q,n,d,m,rho,p);
%     %centering X3 in order to draw
%     X2_temp = X2_temp- repmat(mean(X2_temp),n,1);
%     X2 = [X2; X2_temp];
%     [cluster_ids2_temp, num_clusters_tri_admm, acc2] = evaluate_clustering_result(X2_temp, true_label, n);
%     C2 = [C2; cluster_ids2_temp];
%     if i==num_level
%         if d>2
%             centers = X2*coeff(:,1:2);
%         else if d==2
%                 centers = X2;
%             end
%         end
%      end
%     
    %standard network lasso
%     step = step + step_increase;
%     alpha = alpha*step;
%     [Q,m,sum_triangles] = build_Q('NETWORK LASSO', edge_matrix, weight_matrix,  alpha, n);
%     X3_temp = our_admm(A_std, Q,n,d,m,rho,p);
%     %centering X3 in order to draw 
%     X3_temp = X3_temp- repmat(mean(X3_temp),n,1);
%     X3 = [X3; X3_temp];
%     [cluster_ids3_temp, num_clusters_net_admm, acc3] = evaluate_clustering_result(X3_temp, true_label, n);
%     C3 = [C3; cluster_ids3_temp];
%     if i==num_level
%         if d>2
%             centers = X3*coeff(:,1:2);
%         else if d==2
%                 centers = X3;
%             end
%         end
%     end

    %our dual method
    step = step + step_increase;
    alpha = alpha*step;
    [Q,m,sum_triangles] = build_Q('NETWORK LASSO', edge_matrix, weight_matrix,  alpha, n);
    [X4_temp] = dc_triangle_lasso(A_std, Q, n,d,m);
    %centering X4 in order to draw
    X4_temp = X4_temp- repmat(mean(X4_temp),n,1);
    X4 = [X4; X4_temp];
    [cluster_ids4_temp, num_clusters_tri_admm, acc4] = evaluate_clustering_result(X4_temp, true_label, n);
    C4 = [C4; cluster_ids4_temp];
    %time4 = t4;
    if i==num_level
        if d>2
            centers = X4*coeff(:,1:2);
        else if d==2
                centers = X4;
            end
        end
    end
    
    
    
    
    
end
time = toc;
if d>2
    draw_clusterpath(score(:,1:2),centers,num_level,true_label);
else if d==2
     draw_clusterpath(A_std,centers,num_level,true_label);
    end
end
            



























