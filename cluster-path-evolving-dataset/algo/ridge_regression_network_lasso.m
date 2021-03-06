function [ s_hyp  ] = ridge_regression_network_lasso( s_hyp )
s_hyp.Q = s_hyp.alpha*s_hyp.Q;
A = double(s_hyp.A);
price = s_hyp.true_label;
gamma = 1e-3;
s_hyp.gamma = gamma;

Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;

X_new = zeros(n,d);
Z_new = zeros(m,d);%temp 
U_new = zeros(m,d);%dual variable
rho = 1;
p=2;
% our ADMM
tic;
Delta_temp = zeros(n,n*d);
for k=1:n
    for l=1:d
        Delta_temp(k,k+(l-1)*n) = 1;
    end
end
for i=1:100
    %step 1: update x
    cvx_begin
        variable X(n,d)
        minimize(sum((sum(X .* A,2) - price) .* (sum(X .* A,2) - price)) + gamma*sum(sum(X .* X)) + sum(sum(U_new .* (Q*X - Z_new))) + rho/2*sum(sum((Q*X-Z_new) .* (Q*X-Z_new))) );
        X_new = X;
    cvx_end
    lambda = 1/rho;
    %update Z
    Z_old = Z_new;
    temp = max(1-lambda ./ (norms(Q*X_new + lambda*U_new, p,2)),0);
    Z_new = repmat(temp,1 , d) .* (Q*X_new + lambda * U_new);
    %update U
    U_new = U_new +rho * (Q*X_new - Z_new);
    
    %stopping criterion
    eabs = 1e-2;
    erel = 1e-3;
    epri = sqrt(m)*eabs + erel*max([norm(Q*X_new,2); norm(-1*Z_new,2); 0]);
    edul = sqrt(n)*eabs + erel*norm(Q'*U_new,2);
    r = Q*X_new-Z_new;
    s = rho*Q'*(-1)*(Z_new - Z_old);
    if norm(r,2) <= epri && norm(s,2) <= edul
        break;
    end
end
s_hyp.X = X_new;

s_hyp.time_l2_constraint = toc;
fprintf('>>>>>>>>>>>CPU seconds: %.2f | primal solution \n', s_hyp.time_l2_constraint);

%for robustness
s_hyp.X_record4robustness = [s_hyp.X_record4robustness; s_hyp.X];





end

