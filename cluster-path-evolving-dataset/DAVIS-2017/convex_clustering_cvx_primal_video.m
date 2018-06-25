function [ s_hyp ] = convex_clustering_cvx_primal_video( s_hyp )
s_hyp.Q = s_hyp.alpha*s_hyp.Q;

A = double(s_hyp.A);
Q = s_hyp.Q;
n = s_hyp.n;
d = s_hyp.d;
m = s_hyp.m;

%for test
cvx_begin
variables X(n,d)
minimize ( sum(sum((A-X) .* (A-X))) + sum(norms(Q*X,2,2)));
cvx_end

s_hyp.X = X;
%for robustness
s_hyp.X_record4robustness = [s_hyp.X_record4robustness; X];





end
