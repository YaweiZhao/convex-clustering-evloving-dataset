function[s_hyp] = unware_regularized_convex_clustering(s_hyp)

A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;

%for test
%cvx_begin
%variables X(n,d)
%minimize ( sum(sum((A-X) .* (A-X))) + sum(norms(Q*X,2,2)));
%cvx_end

cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
temp1 = 0.25*kron(eye(d),Q)*transpose(kron(eye(d),Q));
temp2 = -transpose(reshape(A,n*d,1))*transpose(kron(eye(d),Q));
eye_md = sparse(1:m*d,1:m*d,ones(1,m*d));
temp1 = temp1+1e-10*eye_md;
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda);
subject to
norms(lambda,2,2) <= ones(m,1);%l2 norm
%[eye(m);-eye(m)]*lambda <= [ones(m,d);ones(m,d)];%l infty norm
cvx_end
%recover X
X = reshape(A,n*d,1) -0.5*transpose(kron(eye(d),Q))*reshape(lambda,m*d,1);
X = reshape(X,n,d);
s_hyp.X = X;
s_hyp.lambda_opt_vec = [s_hyp.lambda_opt_vec reshape(lambda,m*d,1)];



end