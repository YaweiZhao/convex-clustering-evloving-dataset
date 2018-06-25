function [s_hyp]  = build_network_video(s_hyp)
A = s_hyp.A;
[n,~] = size(A);
edge_matrix = zeros(n,n);
weight_matrix = zeros(n,n);

for i=1:n-1
    diff = sum((repmat(A(i,:),n,1) - A) .* (repmat(A(i,:),n,1) - A),2);
    %diff = sum((A(i,:) - A) .* (A(i,:) - A),2);
    %diff = sum(abs(A(i,:) - A),2);
    [~,distance_id] = sort(diff,'ascend');
        for l=1:s_hyp.num_neighbours                                   %%%%%%%%% number of neighbours
            if distance_id(l) == i || edge_matrix(i,distance_id(l)) == 1
                continue;
            end
            edge_matrix(i,distance_id(l)) = 1;
            
            %weight_matrix(i,distance_id(l)) = exp(-1*5*diff(distance_id(l),1));%for iris dataset
            %weight_matrix(distance_id(l),i) = exp(-1*5*diff(distance_id(l),1));%for iris dataset
            weight_matrix(i,distance_id(l)) = exp(-5*diff(distance_id(l),1));%for moon dataset
            weight_matrix(distance_id(l),i) = exp(-5*diff(distance_id(l),1));%for moon dataset
            %weight_matrix(i,distance_id(l)) = 1/(sqrt(diff(distance_id(l),1))+0.1);%for moon dataset
            %weight_matrix(distance_id(l),i) = 1/(sqrt(diff(distance_id(l),1))+0.1);%for moon dataset
            edge_matrix(distance_id(l),i) = 1;
        end
end
s_hyp.edge_matrix =  edge_matrix;
s_hyp.weight_matrix = weight_matrix;
end