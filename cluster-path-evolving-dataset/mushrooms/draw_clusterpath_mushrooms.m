function[] = draw_clusterpath_mushrooms(s_hyp)

A = s_hyp.data4draw; 
centers = s_hyp.centers;
num_level = s_hyp.num_level;
true_label = s_hyp.true_label;
n = s_hyp.n;

% n = 3089;
% d=2;
% A = load('data_for_draw_svmguide.mat'); 
% A = A.data_for_draw;
% A = A(1:100,:);
% centers = load('centers_svmguide.mat');
% centers = centers.centers;
% temp = transpose(1:100);
% %centers = centers([temp; n+temp; 2*n+temp; 3*n+temp; 4*n+temp],:);
% centers = centers([temp; n+temp; 2*n+temp],:);
% true_label = load('true_label_svmguide.mat');
% true_label = true_label.true_label;
% true_label = true_label +1;
% true_label = true_label(1:100,:);
% num_level = 3;
% n = 100;


for  i=1:num_level
    start_id = (i-1)*n+1;
    end_id = i*n;
    if i == 1
        draw_cluster(A(start_id:end_id,:),centers(start_id:end_id,:),i,true_label);
    else
        old_start_id = start_id-n;
        old_end_id = end_id - n;
        draw_cluster(centers(old_start_id:old_end_id,:),centers(start_id:end_id,:),i,true_label);
    end
end

end


function[] = draw_cluster(source,dest,level,true_label)
[n,d] = size(source);
hold on;
if level == 1
    num_clusters = max(true_label);
    colors = ['g','b','c','k','y', 'm', 'r'];
    for i = 1:min(length(colors), num_clusters)
        scatter(source(true_label==i,1),source(true_label==i,2),[],colors(1,i));
        %set(gca,'yscale','log');
        %set(gca,'xscale','log');
    end
    pax=gca;
    pax.FontSize = 15;
    xlabel('First principal component');%for iris dataset
    ylabel('Second principal component');%for iris dataset
    %xlabel('Feature 1');% for moon dataset
    %ylabel('Feature 2');%for moon dataset
end
hold on;
for i =1:n
    point1=[source(i,1) dest(i,1)];
    point2=[source(i,2) dest(i,2)];
    plot(point1, point2, '-r');
end

end




























