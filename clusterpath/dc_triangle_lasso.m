% solve triangle lasso in dual space
function[X] = dc_triangle_lasso(A, Q, n,d,m)

cvx_begin
variables X_primal(n,d)
minimize (sum(sum((X_primal - A) .* (X_primal - A))) + sum(norms(Q*X_primal,Inf,2)) );
cvx_end
X1 = reshape(X_primal, n*d,1);

cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
temp1 = 0.25*kron(eye(d),Q)*transpose(kron(eye(d),Q));
temp2 = -1*transpose(reshape(A,n*d,1))*transpose(kron(eye(d),Q));
eye_md = sparse(1:m*d,1:m*d,ones(1,m*d));
temp1 = temp1+1e-10*eye_md;
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda);
%minimize (vec_lambda' * temp1 * vec_lambda);
subject to
%norms(lambda,2,2) <= ones(m,1);%l2 norm
[eye(m);-eye(m)]*lambda <= [ones(m,d);ones(m,d)];%l infty norm
cvx_end
%recover X
X = reshape(A,n*d,1) -0.5*transpose(kron(eye(d),Q))*reshape(lambda,m*d,1);
%X = reshape(X,n,d);


%to verify our new closed form
beta =  2*reshape(A,n*d,1);
beta_opt = beta;
Omega = transpose(kron(eye(d),Q));
index_large = beta> Omega * ones(m*d,1);
beta_opt(index_large,:) = 1;
index_small = beta<-Omega * ones(m*d,1);
beta_opt(index_small,:) = -1;
temp_x_opt = reshape(A,n*d,1) - 0.5*beta_opt;



end