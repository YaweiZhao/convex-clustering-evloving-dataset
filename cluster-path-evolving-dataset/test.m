clc;
clear all;
rng('default');

%s_hyp = load_image( s_hyp.fn_image, s_hyp );
%load data and hyper-parameters
s_hyp = prepare_data_cpusmall();
s_hyp = init_parameters_cpusmall(s_hyp);
s_hyp = conduct_cluster_path( s_hyp );

CLUSTER_PATH = false;
CLUSTER_ROBUSTNESS = true;

if CLUSTER_PATH == true
    s_hyp.move_step = 1*s_hyp.move_step;
    s_hyp = get_evolving_data( s_hyp );
    %is_restart = check_unawareness( s_hyp);
    goal_level = 1;
    [is_restart, awareness] = set_unawareness( s_hyp, goal_level);
    %         %cluster path
    %         if is_restart == true
    %             s_hyp = init_parameters(s_hyp);
    %             initialize parameter
    %             s_hyp.move_step = goal_level*s_hyp.move_step;
    %             s_hyp = get_evolving_data( s_hyp );
    %             %conduct_cluster_path_evolving( s_hyp );
    fprintf('#goal level: %d | awareness: %.2f | alpha: %.2f | re-draw the cluster path \n', goal_level, awareness, s_hyp.alpha);
    %         else
    %             do nothing
    %         end
elseif CLUSTER_ROBUSTNESS == true
    %initialize parameter
    %s_hyp = init_parameters(s_hyp);
    s_hyp.move_step = 1*s_hyp.move_step;
    s_hyp = get_evolving_data( s_hyp );
    s_hyp = conduct_cluster_path( s_hyp );
    % compute the robustness
    XX = s_hyp.X_record4robustness;
    interval = s_hyp.n;
    accu_var = 0;
    for j=1:s_hyp.n
        temp = XX(j,:) - XX(j+interval,:);
        accu_var = accu_var + sum(temp .* temp);
    end
    robustness = sqrt(accu_var);
    %save('robustness.txt', 'robustness', '-ascii');
    fprintf( 'algo: %s | beta: %d |  alpha:  %d | robustness (Forbenius norm): %.4f \n',  s_hyp.ALGO, s_hyp.beta,   s_hyp.alpha, robustness);
    
end


