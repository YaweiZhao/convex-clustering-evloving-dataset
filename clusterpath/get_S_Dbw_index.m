function[S_Dbw] = get_S_Dbw_index(S,pred_label,num_clusters)
scat = get_scat(S,pred_label,num_clusters);
dens_bw = get_dens_bw(S,pred_label,num_clusters);
S_Dbw = scat + dens_bw;
end



function[dens_bw] = get_dens_bw(S,pred_label,num_clusters)
dens_bw = 0;
centers = get_cluster_centers(S,pred_label,num_clusters);
stdev = get_stdev(S,pred_label,num_clusters);
for i=1:num_clusters
    for j=1:num_clusters
        if(i==j)
            continue;
        end
        %density U_ij
        if(i==42)
            1+1;
        end
        u_ij = (centers(i,:) + centers(j,:))/2;
        n_ij = sum(pred_label==i) + sum(pred_label==j);
        S_i = S(pred_label==i,:);
        S_j = S(pred_label==j,:);
        S_ij = [S_i;S_j];
        d_temp = S_ij - repmat(u_ij,n_ij,1);
        d = sqrt(sum(d_temp .* d_temp,2));
        diff = repmat(stdev,n_ij,1) - d;
        diff = diff(diff>=0);
        [n_row_diff,~] = size(diff);
        Density_u_ij = n_row_diff;
        %density  v_i
        temp_d_vi = S_ij - repmat(centers(i,:),n_ij,1);
        d_vi = sqrt(sum(temp_d_vi .* temp_d_vi,2));
        diff_vi = repmat(stdev,n_ij,1) - d_vi;
        diff_vi = diff_vi(diff_vi>=0);
        [n_row_diff_vi,~] = size(diff_vi);
        Density_v_i = n_row_diff_vi;
        %density  v_j
        temp_d_vj = S_ij - repmat(centers(j,:),n_ij,1);
        d_vj = sqrt(sum(temp_d_vj .* temp_d_vi,2));
        diff_vj = repmat(stdev,n_ij,1) - d_vj;
        diff_vj = diff_vj(diff_vj>=0);
        [n_row_diff_vj,~] = size(diff_vj);
        Density_v_j = n_row_diff_vj;
        dens_bw = dens_bw + Density_u_ij/(max(Density_v_i, Density_v_j));
    end
end
dens_bw = dens_bw/(num_clusters*(num_clusters-1));
end

function[stdev] = get_stdev(S,pred_label,num_clusters)
%the average standard deviation of clusters
centers = get_cluster_centers(S,pred_label,num_clusters);
norm_sigma_c = 0;
for i=1:num_clusters
    S_i = S(pred_label==i,:);
    [nc_i,~] = size(S_i);
    temp = S_i - repmat(centers(i,:),nc_i,1);
    mean_sigma_c = mean(temp .* temp);
    norm_sigma_c = norm_sigma_c + norm(mean_sigma_c);
end
stdev = sqrt(norm_sigma_c)/num_clusters;
end



function[scat] = get_scat(S,pred_label,num_clusters)
%the variance of a dataset
[n,d] = size(S);
centers = get_cluster_centers(S,pred_label,num_clusters);
S_mean = mean(S);
temp = S - repmat(S_mean,n,1);
sigma_S = mean(temp .* temp);
norm_sigma_S = norm(sigma_S);
%the variance of a cluster
norm_sigma_c = 0;
for i=1:num_clusters
    S_i = S(pred_label==i,:);
    [nc_i,~] = size(S_i);
    temp = S_i - repmat(centers(i,:),nc_i,1);
    mean_sigma_c = mean(temp .* temp);
    norm_sigma_c = norm_sigma_c + norm(mean_sigma_c);
end
norm_sigma_c = norm_sigma_c/num_clusters;
scat = norm_sigma_c/norm_sigma_S;
end


function[centers] = get_cluster_centers(S,pred_label,num_clusters)
[n,d] = size(S);
centers = zeros(num_clusters, d);
for i=1:num_clusters
    S_i = S(pred_label==i,:);
    centers(i,:) = mean(S_i);
end
end




