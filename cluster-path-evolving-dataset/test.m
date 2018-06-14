clc;
clear all;
%rng('default');

%s_hyp = load_image( s_hyp.fn_image, s_hyp );
%load data and hyper-parameters
s_hyp = prepare_data_shuttle();
s_hyp = init_parameters(s_hyp);

s_hyp = conduct_cluster_path( s_hyp );

CLUSTER_PATH = false;
CLUSTER_ROBUSTNESS = true;

for i=1:s_hyp.move_step_num

    if CLUSTER_PATH == true
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
    elseif CLUSTER_ROBUSTNESS == true
        %initialize parameter
        %s_hyp = init_parameters(s_hyp);
        s_hyp.move_step = i*s_hyp.move_step;
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
        robust = sqrt(accu_var);
        fprintf([s_hyp.ALGO '| robustness (Forbenius norm): %.4f \n'], robust);
    end




end


