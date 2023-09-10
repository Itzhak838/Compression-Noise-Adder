%{
Electronics Measurements Final Project:
Name:	Itzhak Shmueli
File Name: main
This file is used to run the scripts for final project.
%}
%% Convert image to gray levels
img = imread('cat.jpeg');      % Read an image
figure(1);
img=rgb2gray(img);
imshow(img);            % Show the image in gray level
imwrite(img,'imtoGray.png');

%% Calling 'compression' to make compression by 1:n ratio
img = imread('cat.jpeg');                % Read an image
obj1=compression;                           % Calling 'compression' class
obj1.One_to_n_image_compression(img,4);    % Naking compression to the image by function
% When running the section,the result image may appear in the main file folder


%% Calling 'Noise_adder' to add a noise to image
img = imread('view.jpeg');      % Read an image
obj2=Noise_adder;               % Calling 'Noise_adder' class
SNR=16;                         
obj2.Noise_img(img,SNR)         % Adding a noise to the image by function
% When running the section,the image may appear in the main file folder


%% Calling "Noise_adder" to create a gaussian mask
img = imread('view.jpeg');      % Read an image
obj3=Noise_adder;               % Calling 'Noise_adder' class
SNR=16;
obj2.Noise_mask(img,SNR)        % Making the mask noise image by function


%% Calling 'Gray_2_boolean' converting inamge to binary level
img=imread('ID_itz.png');
obj4=Gray_2_boolean; 
obj4.converting_2_boolean(img)


%% RGB to gray level converting 
img = imread('ID_itz.png');
gray_img = rgb2gray(img); 
imwrite(gray_img,'RGB_2_gray.jpg')


%% Creating a 32*32 matrix from picture
img = imread('view.jpeg');
img = rgb2gray(img);    
size=32;
sum_mat = uint8(zeros(size, size));
for r = 1:size
    for c = 1:size
       sum_mat(r,c) = img(600+r,c);
    end
end


%% Measuring the matrix sum time
sum = 0;
sum_mat = uint32(sum_mat);
disp('matrix sum time:');
tic
for r = 1:size
    for c = 1:size
        sum = sum + sum_mat(r,c);
    end
end
toc


%% Down sampling 8 gray levels
range=32;
sample_mat=uint8(zeros(size, size));
for r = 1:range
    for c = 1:range
        for ran=1:8
            if(sum_mat(r,c)<ran*range)
               sample_mat(r,c)=(ran-1)*range;
               break;
            end
        end
    end
end


%% Measuring the 8 levels matrix sum time
sum = 0;
disp('8 levels sum time:');
tic
for r = 1:size
    for c = 1:size
        sum = sum + sample_mat(r,c);
    end
end
toc

%% resizing an image
input_image = imread('car.jpeg');
pixels_2_one_pixel=8;
scale_factor = 1/sqrt(pixels_2_one_pixel);
output_image = imresize(input_image, scale_factor);
imshow(output_image);
imwrite(output_image, 'output_image.jpg');

% Note that its possible to resize again with scale factor 1 to spread the
% image to the same dimension as the source image but less information
% saved in memory: imresize(output_image, [rows, columns]);


