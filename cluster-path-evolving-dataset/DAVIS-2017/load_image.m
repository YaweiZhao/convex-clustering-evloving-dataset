function [s_hyp] = load_image( fn_image, s_hyp )
raw_image = imread(fn_image);%RGB array
raw_image_gray = rgb2gray(raw_image);
R = raw_image(:,:,1);
G = raw_image(:,:,2);
B = raw_image(:,:,3);
%imshow(raw_image);
[height, width, ~] = size(raw_image);
scale_height = 10;
scale_width = fix(scale_height*854/480);
%reduce revolution
counter = 0;
for i = 1: fix(height/scale_height)
    for j = 1:fix(width/scale_width)
        counter = counter + 1;
        r = mean(mean(R((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width))); 
        g = mean(mean(G((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width)));
        b  =  mean(mean(B((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width)));
        gray = mean(mean(raw_image_gray((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width))); 
        new_image(i,j,1) = uint8(r);
        new_image(i,j,2) = uint8(g);
        new_image(i,j,3) = uint8(b);
        %A(counter,:) = [r, g, b];
        A(counter,:) = gray;
    end
end
s_hyp.height = fix(height/scale_height);
s_hyp.width = fix(width/scale_width);
A_std = transpose(mapstd(A'));
s_hyp.A = A_std;%normalized data
[s_hyp.n, s_hyp.d] = size(A);
%imshow(new_image);
imwrite(new_image, s_hyp.new_color_image_name);
end

