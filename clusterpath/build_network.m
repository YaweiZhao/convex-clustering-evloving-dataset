function [edge_matrix, weight_matrix ] = build_network(A, type, param_value)
[n,~] = size(A);
edge_matrix = zeros(n,n);
weight_matrix = zeros(n,n);

for i=1:n-1
    diff = sum((repmat(A(i,:),n,1) - A) .* (repmat(A(i,:),n,1) - A),2);
    [~,distance_id] = sort(diff,'ascend');
    if strcmp(type, 'NEIGHBOURS')
        num_neighbours = param_value;
        for l=1:num_neighbours                                   %%%%%%%%% number of neighbours
            if distance_id(l) == i || edge_matrix(i,distance_id(l)) == 1
                continue;
            end
            edge_matrix(i,distance_id(l)) = 1;
            
            %weight_matrix(i,distance_id(l)) = exp(-1*5*diff(distance_id(l),1));%for iris dataset
            %weight_matrix(distance_id(l),i) = exp(-1*5*diff(distance_id(l),1));%for iris dataset
            weight_matrix(i,distance_id(l)) = exp(-1*diff(distance_id(l),1));%for moon dataset
            weight_matrix(distance_id(l),i) = exp(-1*diff(distance_id(l),1));%for moon dataset
            %weight_matrix(i,distance_id(l)) = 1/(sqrt(diff(distance_id(l),1))+0.1);%for moon dataset
            %weight_matrix(distance_id(l),i) = 1/(sqrt(diff(distance_id(l),1))+0.1);%for moon dataset
            edge_matrix(distance_id(l),i) = 1;
        end
    end
end

end