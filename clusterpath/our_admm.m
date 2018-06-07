function [X_new] = our_admm( A, Q,n,d,m,rho,p)
 X_new = zeros(n,d);
 Z_new = zeros(m,d);%temp 
 U_new = zeros(m,d);%dual variable

% our ADMM
Delta_temp = zeros(n,n*d);
for k=1:n
    for l=1:d
        Delta_temp(k,k+(l-1)*n) = 1;
    end
end
for i=1:100
    %update X, for  a general convex objective function. using linear
    %equation
    
    Phi2 = transpose(reshape(Z_new,m*d,1))*kron(eye(d),Q);
    Omega2 = transpose(kron(eye(d),Q)) * (kron(eye(d),Q));
    
    temp1 = 2*eye(n*d) + rho*Omega2;
    temp2 = 2*reshape(A,n*d,1)+rho*transpose(Phi2)-transpose(kron(eye(d),Q))*reshape(U_new,m*d,1);
    X_new_temp = linsolve(temp1,temp2);
    X_new = reshape(X_new_temp,n,d);
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

end

