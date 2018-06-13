function [ s_hyp  ] = network_lasso( s_hyp )
s_hyp.Q = s_hyp.alpha*s_hyp.Q;

Q = s_hyp.Q;
A = s_hyp.A;
n = s_hyp.n;
m = s_hyp.m;
d = s_hyp.d;
rho = 1;
p=2;

X_new = zeros(n,d);
 Z_new = zeros(m,d);%temp 
 U_new = zeros(m,d);%dual variable

% our ADMM
tic;
Delta_temp = zeros(n,n*d);
for k=1:n
    for l=1:d
        Delta_temp(k,k+(l-1)*n) = 1;
    end
end
for i=1:200
    %step 1: update x
    cvx_begin
        variable X(n,d)
        minimize(sum(sum((X - A) .* (X-A))) + sum(sum(U_new .* (Q*X - Z_new))) + rho/2*sum(sum((Q*X-Z_new) .* (Q*X-Z_new))) );
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
time = toc;
s_hyp.X_network_lasso = X_new;
s_hyp.time_network_lasso = time;

end

