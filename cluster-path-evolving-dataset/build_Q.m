function [s_hyp] = build_Q(s_hyp)
edge_matrix = s_hyp.edge_matrix;
weight_matrix = s_hyp.weight_matrix;
alpha = s_hyp.alpha;

m = sum(sum(edge_matrix))/2;
n = s_hyp.n;
Q= zeros(m,n);
counter = 0;
for i=1:n-1
    for j=i+1:n
        if(edge_matrix(i,j) == 1)
            counter = counter + 1;
            Q(counter,i) = alpha*weight_matrix(i,j);
            Q(counter,j) = -alpha*weight_matrix(i,j);
        end
    end
end
s_hyp.m = m;
s_hyp.Q = Q;
end

