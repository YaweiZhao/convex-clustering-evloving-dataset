function [ s_hyp ] = get_evolving_data( s_hyp )

true_label = s_hyp.true_label;
%moving some data
target_position1 = min(s_hyp.A);
target_position2 = max(s_hyp.A);
move_data_cluster = zeros(s_hyp.n,s_hyp.d);

for j = 1:s_hyp.num_move_data
    if true_label(j) == 1
        move_data_cluster(j,:) =  s_hyp.move_step*(target_position1 - s_hyp.A(j,:));
    elseif true_label(j) == 2
        move_data_cluster(j,:) =  s_hyp.move_step*(target_position2 - s_hyp.A(j,:));
    elseif true_label(j) == 3
        move_data_cluster(j,:) =  s_hyp.move_step*(-1*target_position1 - s_hyp.A(j,:));
    elseif true_label(j) == 4
        move_data_cluster(j,:) =  s_hyp.move_step*(-1*target_position2 - s_hyp.A(j,:));
    end
end

s_hyp.A = s_hyp.A + move_data_cluster;
s_hyp.move_data_cluster = move_data_cluster;
%scatter(s_hyp.A(:,1), s_hyp.A(:,2));



end

