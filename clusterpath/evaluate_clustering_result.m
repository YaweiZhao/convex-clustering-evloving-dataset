function [cluster_ids, num_clusters, acc ] = evaluate_clustering_result(X, true_label, n)
counter = 0;
acc=0;
cluster_ids = zeros(n,1);
for n_c = 1:n-1
    if cluster_ids(n_c,1)==0
        counter=counter+1;
        cluster_ids(n_c,1) = counter;
        temp = X(n_c,:);
        for n_c2 = n_c+1:n
            if cluster_ids(n_c2,1)==0 && norm(temp-X(n_c2,:))<1e-4
                cluster_ids(n_c2,1) = counter;
            end
        end
    end
end
num_clusters = max(cluster_ids);
if num_clusters <= 2% three clusters: 0, 1, 2
    acc = cluster_acc(true_label, cluster_ids);
end
%fn = ['clustering_result_', noise_type, network_type, algo_type, '.txt'];
%save(fn, 'cluster_ids','-ascii');
end

