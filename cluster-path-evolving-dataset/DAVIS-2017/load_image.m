function [s_hyp] = load_image( fn_image, s_hyp )
raw_image = imread(fn_image);%RGB array
raw_image_gray = rgb2gray(raw_image);
R = raw_image(:,:,1);
G = raw_image(:,:,2);
B = raw_image(:,:,3);
%imshow(raw_image);
[height, width, ~] = size(raw_image);
scale_height = 30;
scale_width = fix(scale_height*854/480);

%gray image with lines
raw_image_gray_lines = draw_line_image(raw_image_gray, scale_height, scale_width);
%imshow(raw_image_gray_lines);
imwrite(raw_image_gray_lines, 'gray_plane_cross15_lines.jpg');
%reduce revolution
counter = 0;
for i = 1: fix(height/scale_height)
    for j = 1:fix(width/scale_width)
        
        counter = counter + 1;
        r = mean(mean(R((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width))); 
        g = mean(mean(G((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width)));
        b  =  mean(mean(B((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width)));
        gray = max(max(raw_image_gray((i-1)*scale_height+1:i*scale_height, (j-1)*scale_width+1:j*scale_width))); 
        new_image(i,j,1) = uint8(r);
        new_image(i,j,2) = uint8(g);
        new_image(i,j,3) = uint8(b);
        A(counter,1) = gray;
        A(counter,2:3) = [i,j];
    end
end

s_hyp.height = fix(height/scale_height);
s_hyp.width = fix(width/scale_width);
A = double(A);
A_std = transpose(mapstd(A'));
s_hyp.A = A_std;%normalized data
[s_hyp.n, s_hyp.d] = size(A);
%imshow(new_image);
%imwrite(new_image, s_hyp.new_color_image_name);
end

function[gray_image] = draw_line_image(gray_image, scale_height, scale_width)
[height, width, ~] = size(gray_image);

num_height = fix(height/scale_height);
num_width = fix(width/scale_width);
for i=1:num_height
    for j=1:num_width
        
        gray_image((i-1)*scale_height+1:i*scale_height,(j-1)*scale_width+1) = 255;
        gray_image((i-1)*scale_height+1:i*scale_height,j*scale_width) = 255;
        gray_image((i-1)*scale_height+1,(j-1)*scale_width+1:j*scale_width) = 255;
        gray_image(i*scale_height,(j-1)*scale_width+1:j*scale_width) = 255;
    end
end


end

