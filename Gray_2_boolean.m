%{
The script is designed to compress an image by converting from gray level to boolean.
If the pixel value is bigger than 128 - it will be mapped to 255.
If the pixel value is lower or equal to 128 - it will be mapped to 0.
%}


classdef Gray_2_boolean % Add a class to use from other functions
    methods
        function converting_2_boolean(obj,img)
            img = rgb2gray(img);     % Converting for to gray levels for case save 
            rows = size(img,1);      
            columns = size(img,2);
            boolean_img = img;      % Create a new matrix for boolean image
            
            for r = 1:rows          % Loop the matrices to creat the new boolean image
                for c = 1:columns
                    if boolean_img(r,c) > 256/2
                        boolean_img(r,c) = 255;
                    else
                        boolean_img(r,c) = 0;
                    end
                end
            end
            imwrite(boolean_img,'gray_2_boolean.png');     % Saving the boolean image to folder
        end
    end
end