function[s_hyp] = unware_regularized_ridge_regression(s_hyp)
s_hyp.Q = s_hyp.alpha*s_hyp.Q;
s_hyp = solve_cvx_dual_problem(s_hyp);






end



function [s_hyp]= solve_cvx_dual_problem(s_hyp)

fprintf('>>>>>>>>>>>>>>>>>>>>alpha: %.2f \n', s_hyp.alpha);
s_hyp.regnorm = 1;% regulared norm: 1, 2, inf
%s_hyp = solve_l1_constraint(s_hyp);
s_hyp = solve_l2_constraint(s_hyp);
%s_hyp = solve_linf_constraint_parallel(s_hyp);
%s_hyp = solve_linf_constraint(s_hyp);


end

function [s_hyp] = solve_l1_constraint(s_hyp)
A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;
beta = s_hyp.beta;

Delta_temp = zeros(n,n*d);
for i=1:n
    for j=1:d
        Delta_temp(i,i+(j-1)*n) = 1;
    end
end

Delta = Delta_temp*diag(reshape(A,n*d,1));
Omega = Delta'*Delta + gamma*eye(n*d);
%D = [eye(d-1); zeros(1,d-1)];
%Omega = Delta'*Delta + gamma*transpose(kron(D',eye(n))) * kron(D',eye(n));
Phi = price'*Delta;
temp1 = 0.25*kron(eye(d),Q)*inv(Omega)*transpose(kron(eye(d),Q));
temp1 = temp1 + 1e-5*eye(m*d);%make sure temp1 is full rank in order to make the quadratic problem is convex
temp1 = 0.5*(temp1+temp1');
%temp1 = 0.5*inv(Omega);
temp2 = -1*Phi*inv(Omega)*(transpose(kron(eye(d),Q)));

%quadprog(temp1,temp2); 
tic;
cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
norms(lambda,1,2) <= ones(m,1);
cvx_end
%recover X
X = -0.5*inv(Omega)*transpose(-2*Phi + transpose(reshape(lambda,m*d,1))*kron(eye(d),Q));
X = reshape(X,n,d);

s_hyp.time_l1_constraint = toc;
fprintf('>>>>>>>>>>>CPU seconds: %.2f | l1 norm constraint \n', s_hyp.time_l1_constraint);

%for robustness
s_hyp.X_record4robustness = [s_hyp.X_record4robustness; s_hyp.X];

s_hyp.lambda_opt_vec = [s_hyp.lambda_opt_vec reshape(lambda,m*d,1)];

end


function [s_hyp] = solve_l2_constraint(s_hyp)
A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;
beta = s_hyp.beta;
gamma = 1e-3;
s_hyp.gamma = gamma;
price = s_hyp.true_label;

Delta_temp = zeros(n,n*d);
for i=1:n
    for j=1:d
        Delta_temp(i,i+(j-1)*n) = 1;
    end
end

Delta = Delta_temp*diag(reshape(A,n*d,1));
Omega = Delta'*Delta + gamma*eye(n*d);
%D = [eye(d-1); zeros(1,d-1)];
%Omega = Delta'*Delta + gamma*transpose(kron(D',eye(n))) * kron(D',eye(n));
Phi = price'*Delta;
temp1 = 0.25*kron(eye(d),Q)*inv(Omega)*transpose(kron(eye(d),Q));
temp1 = temp1 + 1e-5*eye(m*d);%make sure temp1 is full rank in order to make the quadratic problem is convex
temp1 = 0.5*(temp1+temp1');
%temp1 = 0.5*inv(Omega);
temp2 = -1*Phi*inv(Omega)*(transpose(kron(eye(d),Q)));

%quadprog(temp1,temp2); 
tic;
cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
norms(lambda,2,2) <= ones(m,1);
cvx_end
%recover X
X = -0.5*inv(Omega)*transpose(-2*Phi + transpose(reshape(lambda,m*d,1))*kron(eye(d),Q));
s_hyp.X = reshape(X,n,d);

s_hyp.time_l2_constraint = toc;
fprintf('>>>>>>>>>>>CPU seconds: %.2f | l2 norm constraint \n', s_hyp.time_l2_constraint);

%for robustness
s_hyp.X_record4robustness = [s_hyp.X_record4robustness; s_hyp.X];

s_hyp.lambda_opt_vec = [s_hyp.lambda_opt_vec reshape(lambda,m*d,1)];

end


function [s_hyp] = solve_linf_constraint(s_hyp)
A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;
beta = s_hyp.beta;

Delta_temp = zeros(n,n*d);
for i=1:n
    for j=1:d
        Delta_temp(i,i+(j-1)*n) = 1;
    end
end

Delta = Delta_temp*diag(reshape(A,n*d,1));
Omega = Delta'*Delta + gamma*eye(n*d);
%D = [eye(d-1); zeros(1,d-1)];
%Omega = Delta'*Delta + gamma*transpose(kron(D',eye(n))) * kron(D',eye(n));
Phi = price'*Delta;
temp1 = 0.25*kron(eye(d),Q)*inv(Omega)*transpose(kron(eye(d),Q));
temp1 = temp1 + 1e-5*eye(m*d);%make sure temp1 is full rank in order to make the quadratic problem is convex
temp1 = 0.5*(temp1+temp1');
%temp1 = 0.5*inv(Omega);
temp2 = -1*Phi*inv(Omega)*(transpose(kron(eye(d),Q)));

%quadprog(temp1,temp2); 
tic;
cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
norms(lambda,Inf,2) <= ones(m,1);
cvx_end
%recover X
X = -0.5*inv(Omega)*transpose(-2*Phi + transpose(reshape(lambda,m*d,1))*kron(eye(d),Q));
X = reshape(X,n,d);

s_hyp.time_linf_constraint = toc;
fprintf('>>>>>>>>>>>CPU seconds: %.2f | l-Inf norm constraint \n', s_hyp.time_linf_constraint);

%for robustness
s_hyp.X_record4robustness = [s_hyp.X_record4robustness; s_hyp.X];

s_hyp.lambda_opt_vec = [s_hyp.lambda_opt_vec reshape(lambda,m*d,1)];

end

function [s_hyp] = solve_linf_constraint_parallel(s_hyp)
A = double(s_hyp.A(:,1));
Q = s_hyp.Q;
n = s_hyp.n;
d = 1;       %parallel  for l-infty norm constraint
m = s_hyp.m;
beta = s_hyp.beta;

tic;
Delta_temp = zeros(n,n*d);
for i=1:n
    for j=1:d
        Delta_temp(i,i+(j-1)*n) = 1;
    end
end

Delta = Delta_temp*diag(reshape(A,n*d,1));
Omega = Delta'*Delta + gamma*eye(n*d);
%D = [eye(d-1); zeros(1,d-1)];
%Omega = Delta'*Delta + gamma*transpose(kron(D',eye(n))) * kron(D',eye(n));
Phi = price'*Delta;
temp1 = 0.25*kron(eye(d),Q)*inv(Omega)*transpose(kron(eye(d),Q));
temp1 = temp1 + 1e-5*eye(m*d);%make sure temp1 is full rank in order to make the quadratic problem is convex
temp1 = 0.5*(temp1+temp1');
%temp1 = 0.5*inv(Omega);
temp2 = -1*Phi*inv(Omega)*(transpose(kron(eye(d),Q)));

%quadprog(temp1,temp2); 

cvx_begin
variables lambda(m,d)
vec_lambda = reshape(lambda,m*d,1);
minimize (vec_lambda' * temp1 * vec_lambda + temp2*vec_lambda ...
    + beta*norm(transpose(kron(eye(d),Q))*vec_lambda,s_hyp.regnorm));
subject to
norms(lambda,Inf,2) <= ones(m,1);
cvx_end
%recover X
X = -0.5*inv(Omega)*transpose(-2*Phi + transpose(reshape(lambda,m*d,1))*kron(eye(d),Q));
X = reshape(X,n,d);

s_hyp.time_linf_constraint = toc;
fprintf('>>>>>>>>>>>CPU seconds: %.2f | linf norm constraint \n', s_hyp.time_linf_constraint);


%for robustness


end



































