function [ X_new, time ] = standard_admm(A,Q,n,d,m,rho,p)

X_new = zeros(n,d);%primal variable
Z_new = zeros(m,d);%temp 
U_new = zeros(m,d);%dual variable
for i = 1:100%end
    %step 1: update x
    cvx_begin
        variable X(n,d)
        minimize(sum(sum((X-A) .* (X-A))) + sum(sum(U_new .* (Q*X - Z_new))) + rho/2*sum(sum((Q*X-Z_new) .* (Q*X-Z_new))) );
        X_new = X;
    cvx_end
    %step 2: update z
    Z_old = Z_new;
    cvx_begin
        variable Z(m,d)
        minimize(sum(norms(Z,p,2)) + sum(sum(U_new .* (Q*X_new - Z))) + rho/2*sum(sum((Q*X_new - Z) .* (Q*X_new - Z)))  );
        Z_new = Z;
    cvx_end
    %step 3: update U
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

end

