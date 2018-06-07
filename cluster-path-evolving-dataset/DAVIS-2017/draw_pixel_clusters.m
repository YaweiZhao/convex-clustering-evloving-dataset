function [] = draw_pixel_clusters( s_hyp )

X = s_hyp.X;
unique_elements = unique(X(:,1));%use gray channel
num_clusters = length(unique_elements);

height = s_hyp.height;
width = s_hyp.width;
%R = uint8(zeros(height,width));
%G = uint8(zeros(height,width));
%B = uint8(zeros(height,width));
for k = 1:num_clusters
    ele = unique_elements(k);
    counter = 0;
    for i=1:height
        for j=1:width
            counter = counter + 1;
            if abs(X(counter,1) - ele) < 2 %use gray channel
                gray(i,j) = ele;
                %R(i,j) = uint8(255/num_clusters*k);
                %G(i,j) = uint8(255/num_clusters*k);
                %B(i,j) = uint8(255/num_clusters*k);
            end
        end
    end
end
%new_image(:,:,1) = R;
%new_image(:,:,2) = G;
%new_image(:,:,3) = B;

%imshow(gray);
imwrite(gray, s_hyp.handled_image_name);


fprintf('alpha: %f | #clusters: %d \n', s_hyp.alpha, num_clusters);











end

