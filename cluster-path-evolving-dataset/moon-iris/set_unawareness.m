function [is_restart, awareness] = set_unawareness( s_hyp, level)
Delta = s_hyp.move_data_cluster;
lambda_opt_vec = s_hyp.lambda_opt_vec;
m = s_hyp.m;
n = s_hyp.n;
d= s_hyp.d;
Q = s_hyp.Q;
[~,num_lambda] = size(lambda_opt_vec);
for i=1:num_lambda
    lambda = lambda_opt_vec(:,i);
    temp = transpose(reshape(Delta,n*d,1))*transpose(kron(eye(d),Q))*lambda;
    
    if level ==i
       awareness = max(abs(temp));
       fprintf('[YES:%d]  awareness: %.2f. restart convex clustering\n', i, awareness);
        is_restart = true;
    end

end








end

