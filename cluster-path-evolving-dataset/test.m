clc;
clear all;
rng('default');

%s_hyp = load_image( s_hyp.fn_image, s_hyp );
%load data and hyper-parameters
s_hyp = prepare_data();
s_hyp = init_parameters(s_hyp);

s_hyp = conduct_cluster_path( s_hyp );

for i=1:s_hyp.move_step_num

    %initialize parameter
    s_hyp.move_step = i*s_hyp.move_step;
    s_hyp = get_evolving_data( s_hyp );
    is_restart = check_unawareness( s_hyp);
    %cluster path
    if is_restart == true
        s_hyp = init_parameters(s_hyp);
        %initialize parameter
        s_hyp.move_step = i*s_hyp.move_step;
        s_hyp = get_evolving_data( s_hyp );
        conduct_cluster_path( s_hyp );
        break;
    else
        %do nothing
    end




end

