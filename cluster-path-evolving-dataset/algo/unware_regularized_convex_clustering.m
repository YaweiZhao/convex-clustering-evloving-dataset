function[s_hyp] = unware_regularized_convex_clustering(s_hyp)
s_hyp.Q = s_hyp.alpha*s_hyp.Q;

s_hyp = solve_cvx_dual_problem(s_hyp);






end



function [s_hyp]= solve_cvx_dual_problem(s_hyp)

fprintf('>>>>>>>>>>>>>>>>>>>>alpha: %.2f \n', s_hyp.alpha);
s_hyp.regnorm = 1;% regulared norm: 1, 2, inf
s_hyp = solve_l1_constraint(s_hyp);
s_hyp = solve_l2_constraint(s_hyp);
s_hyp = solve_linf_constraint(s_hyp);
s_hyp = solve_linf_constraint_parallel(s_hyp);

%for robustness
s_hyp.X_record4robustness = [s_hyp.X_record4robustness; s_hyp.X];

s_hyp.lambda_opt_vec = [s_hyp.lambda_opt_vec reshape(lambda,m*d,1)];

end

function [s_hyp] = solve_l1_constraint(s_hyp)
A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;
beta = 5;
s_hyp.beta = beta;

tic;
cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
temp1 = 0.25*kron(eye(d),Q)*transpose(kron(eye(d),Q));
temp2 = -transpose(reshape(A,n*d,1))*transpose(kron(eye(d),Q));
eye_md = sparse(1:m*d,1:m*d,ones(1,m*d));
temp1 = temp1+1e-8*eye_md;
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
norms(lambda,1,2) <= ones(m,1);%l1 norm
%norms(lambda,2,2) <= ones(m,1);%l2 norm
%norms(lambda,Inf,2) <= ones(m,1);%l-Inf norm
cvx_end
toc;
s_hyp.time_l1_constraint = toc - tic;
fprintf('CPU seconds: %.2f | l1 norm constraint \n', s_hyp.time_l1_constraint);

%recover X
X = reshape(A,n*d,1) -0.5*transpose(kron(eye(d),Q))*reshape(lambda,m*d,1);
s_hyp.X = reshape(X,n,d);
end


function [s_hyp] = solve_l2_constraint(s_hyp)
A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;
beta = 5;
s_hyp.beta = beta;

tic;
cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
temp1 = 0.25*kron(eye(d),Q)*transpose(kron(eye(d),Q));
temp2 = -transpose(reshape(A,n*d,1))*transpose(kron(eye(d),Q));
eye_md = sparse(1:m*d,1:m*d,ones(1,m*d));
temp1 = temp1+1e-8*eye_md;
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
norms(lambda,2,2) <= ones(m,1);%l2 norm
%norms(lambda,Inf,2) <= ones(m,1);%l-Inf norm
cvx_end
toc;
s_hyp.time_l2_constraint = toc - tic;
fprintf('CPU seconds: %.2f | l2 norm constraint \n', s_hyp.time_l2_constraint);

%recover X
X = reshape(A,n*d,1) -0.5*transpose(kron(eye(d),Q))*reshape(lambda,m*d,1);
s_hyp.X = reshape(X,n,d);
end


function [s_hyp] = solve_linf_constraint(s_hyp)
A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;
beta = 5;
s_hyp.beta = beta;

tic;
cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
temp1 = 0.25*kron(eye(d),Q)*transpose(kron(eye(d),Q));
temp2 = -transpose(reshape(A,n*d,1))*transpose(kron(eye(d),Q));
eye_md = sparse(1:m*d,1:m*d,ones(1,m*d));
temp1 = temp1+1e-8*eye_md;
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
norms(lambda,Inf,2) <= ones(m,1);%l-Inf norm
cvx_end
toc;
s_hyp.time_linf_constraint = toc - tic;
fprintf('CPU seconds: %.2f | Infty norm constraint \n', s_hyp.time_linf_constraint);

%recover X
X = reshape(A,n*d,1) -0.5*transpose(kron(eye(d),Q))*reshape(lambda,m*d,1);
s_hyp.X = reshape(X,n,d);
end

function [s_hyp] = solve_linf_constraint_parallel(s_hyp)
A = double(s_hyp.A(:,1));
Q = s_hyp.Q;
n = s_hyp.n;
d = 1;       %parallel  for l-infty norm constraint
m = s_hyp.m;
beta = 5;
s_hyp.beta = beta;

tic;
cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
temp1 = 0.25*kron(eye(d),Q)*transpose(kron(eye(d),Q));
temp2 = -transpose(reshape(A,n*d,1))*transpose(kron(eye(d),Q));
eye_md = sparse(1:m*d,1:m*d,ones(1,m*d));
temp1 = temp1+1e-8*eye_md;
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
[eye(m);-eye(m)]*lambda <= [ones(m,d);ones(m,d)];%l infty norm
cvx_end
toc;
s_hyp.time_linf_constraint_parallel = toc - tic;
fprintf('>>>PARALLEL: CPU seconds: %.2f | Infty norm constraint \n', s_hyp.time_linf_constraint_parallel);
%recover X
X = reshape(A,n*d,1) -0.5*transpose(kron(eye(d),Q))*reshape(lambda,m*d,1);
s_hyp.X = reshape(X,n,d);
end


function [s_hyp] = solve_admm_l1_constraint(s_hyp)
 
end

function [s_hyp] = solve_admm_l2_constraint(s_hyp)


end

function [s_hyp] = solve_admm_linf_constraint(s_hyp)
 

end

function [s_hyp] = solve_admm_linf_constraint_parallel(s_hyp)


end



































