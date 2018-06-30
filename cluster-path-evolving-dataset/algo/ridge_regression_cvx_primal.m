function [ s_hyp ] = ridge_regression_cvx_primal( s_hyp )
s_hyp.Q = s_hyp.alpha*s_hyp.Q;

A = double(s_hyp.A);
price = s_hyp.true_label;
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;

tic
%for test
cvx_begin
variables X(n,d)
minimize ( sum(transpose(sum(A .* X, 2) - price) * (sum(A .* X, 2) - price)) + sum(norms(Q*X,2,2)));
cvx_end

s_hyp.X = X;

s_hyp.time_l2_constraint = toc;
fprintf('>>>>>>>>>>>CPU seconds: %.2f | primal solution \n', s_hyp.time_l2_constraint);

%for robustness
s_hyp.X_record4robustness = [s_hyp.X_record4robustness; s_hyp.X];





end
