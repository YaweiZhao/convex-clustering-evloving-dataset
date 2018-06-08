function [is_restart] = check_unawareness( s_hyp)
control_awareness = s_hyp.control_awareness;
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
    if abs(temp) > control_awareness
        fprintf('[YES:%d] change: %.2f | awareness: %.2f. restart convex clustering\n', i, abs(temp), control_awareness);
        is_restart = true;
        %break;
    else
        fprintf('[NO:%d] change: %.2f | awareness: %.2f. continue...\n', i, abs(temp), control_awareness);
        is_restart = false;
    end

end








end

