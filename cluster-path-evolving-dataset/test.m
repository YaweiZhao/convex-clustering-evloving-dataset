clc;
clear all;
rng('default');

%load data and hyper-parameters
s_hyp = prepare_data();
s_hyp = init_parameters(s_hyp);
%s_hyp = load_image( s_hyp.fn_image, s_hyp );

n = s_hyp.n;
d = s_hyp.d;
A = s_hyp.A;
num_level = s_hyp.num_level;

s_hyp = conduct_cluster_path( s_hyp );

for i=1:s_hyp.move_step_num

s_hyp.move_step = i*s_hyp.move_step;
s_hyp = get_evolving_data( s_hyp );
is_restart = check_unawareness( s_hyp);
%cluster path
if is_restart == true
    conduct_cluster_path( s_hyp );
else
    %do nothing
end




end

