function [ s_hyp ] = get_evolving_data( s_hyp )

%moving some data
target_position1 = min(s_hyp.A);
s_hyp.noise_type = 'UNIFORM NOISE';
if strcmp(s_hyp.noise_type, 'SPARSE NOISE')
    move_data_cluster = 0.05*[ones(s_hyp.n,1) zeros(s_hyp.n,s_hyp.d - 1)] .* (target_position1 - s_hyp.A);
elseif strcmp(s_hyp.noise_type, 'UNIFORM NOISE')
    move_data_cluster = 0.05*ones(s_hyp.n,s_hyp.d) .* (target_position1 - s_hyp.A);
elseif strcmp(s_hyp.noise_type, 'MIXED NOISE')
    move_data_cluster = [0.1*ones(s_hyp.n,1) 0.01*ones(s_hyp.n,s_hyp.d-1)] .* (target_position1 - s_hyp.A);
else
    move_data_cluster =  s_hyp.move_step*(target_position1 - s_hyp.A);% for general noise
end


s_hyp.A = s_hyp.A + move_data_cluster;
s_hyp.move_data_cluster = move_data_cluster;
%scatter(s_hyp.A(:,1), s_hyp.A(:,2));



end

