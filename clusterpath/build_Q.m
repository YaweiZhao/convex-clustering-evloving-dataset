function [Q,m,sum_triangles] = build_Q(type, edge_matrix, weight_matrix,  alpha, n)
m = sum(sum(edge_matrix))/2;
Q= zeros(m,n);
triangle_matrix = zeros(n,n);
counter = 0;
sum_triangles = 0;
for i=1:n-1
    for j=i+1:n
        if(edge_matrix(i,j) == 1)
            counter = counter + 1;
            if strcmp(type, 'TRIANGLE LASSO')
                for k=1:n
                    if edge_matrix(i,k) == 1 && edge_matrix(j,k) == 1
                        triangle_matrix(i,j) = triangle_matrix(i,j)+1;
                        triangle_matrix(j,i) = triangle_matrix(j,i)+1;
                        sum_triangles = sum_triangles+1;
                    end
                end
                Q(counter,i) = alpha*weight_matrix(i,j)*(1+ triangle_matrix(i,j));
                Q(counter,j) = -1*alpha*weight_matrix(i,j)*(1+ triangle_matrix(i,j));
            else if strcmp(type, 'NETWORK LASSO')
                    Q(counter,i) = alpha*weight_matrix(i,j);
                    Q(counter,j) = -1*alpha*weight_matrix(i,j);
                end
            end
        end
    end
end

%accound for the number of triangles


end

