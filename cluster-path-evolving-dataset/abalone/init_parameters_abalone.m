function [s_hyp] = init_parameters_abalone(s_hyp)





%settings for convex clustering
s_hyp = init_param_datasets(s_hyp);

%build network
s_hyp = build_network(s_hyp);
s_hyp = build_Q_no_alpha(s_hyp);





end

function s_hyp = init_param_datasets(s_hyp)
s_hyp.TASK_TYPE = 'ridge_regression';
%s_hyp.ALGO = 'CVX-PRIMAL';
%s_hyp.ALGO = 'CVX-PRIMAL-2011';
s_hyp.ALGO = 'our_method';
%s_hyp.ALGO = 'NETWORK_LASSO';
if strcmp(s_hyp.ALGO, 'our_method')
    s_hyp.beta = 1;
else
    s_hyp.beta = 0;
end

s_hyp.num_neighbours =5;
s_hyp.alpha = 10; %hyper-parameter for regularized item, 10 in default
s_hyp.num_level = 1;

s_hyp.num_move_data = fix(s_hyp.n/10);
s_hyp.move_step = 0.2; %set 0 for no evolving data
s_hyp.move_step_num = 1;%set 0 for no evolving data
s_hyp.control_awareness = 10000;
s_hyp.lambda_opt_vec = [];

%for robustness
s_hyp.X_record4robustness = [];

end

function s_hyp = init_param_video_dataset()
%for video dataset
s_hyp.fn_image = './IMAGES/planes-crossing/00016.jpg';
fn_image_len = length(s_hyp.fn_image);
s_hyp.new_color_image_name = ['new_color_planes-crossing_'  s_hyp.fn_image( fn_image_len-8:fn_image_len)];
s_hyp.handled_image_name = ['handled_planes-crossing_' s_hyp.fn_image( fn_image_len-8:fn_image_len)];
s_hyp.alpha = 100000; %for video dataset
s_hyp.num_neighbours = 4;
s_hyp.num_level = 1;
end

