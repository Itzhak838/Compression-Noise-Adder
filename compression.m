%{
The script performs compression in the image plane.
Compressing the image at a ratio of 1:n, when n is an integer.
If the root of n is an integer the function will compress an area of ​​n*n pixels to one value.
If the root of n is not an integer then the function compresses a neighborhood of n pixels in the x axis.
The algorithm uses the mean to calculate the pixel neighborhood value.
The compression is expressed by the fact that we will get a similar value
for a pixel environment, which saves space in memory.
%}
classdef compression  % Add a class to use from other functions
    methods


        function One_to_n_image_compression(obj,img,n_comp) % Get in an image and the n tario to compress by
        img = rgb2gray(img);        % Convert to gray
        img = uint16(img);          % Convert to 16-bit unsigned integer in order to not lose values
        rows = size(img,1);         % Take the matrix length 
        columns  = size(img,2);
        img_comp= uint8(zeros(rows, columns)); % Create a new matrix for 

        if mod(sqrt(n_comp), 1) ~=0        % Checking if the sqrt of the number is not an integer
            for r = 1:rows                 % Loop the rows and columns of the image before compression
                for c = 1:columns/n_comp
                    avg = 0;               % Calculate the average:
                    for t=1:n_comp         % Loop the n pixels environment
                        avg=avg + (img(r,n_comp*c-(n_comp-t)))/n_comp;        
                
                    end
                    for t=1:n_comp         % Get in to the average value to compressed image
                        img_comp(r,n_comp*c-(n_comp-t))=avg;           
                    end
            
                end
            end 
        else    % If the sqrt of the number is an integer 
            for r = 1:(rows/sqrt(n_comp))            % Loop the rows and columns of the image before compression
                for c = 1:(columns/sqrt(n_comp))     
                    avg = 0;                         % Calculate the average:
                    for i = 0:(sqrt(n_comp) - 1)     % Loop the n*n pixels environment
                        for j = 0:(sqrt(n_comp) - 1)    
                            avg = avg + img(sqrt(n_comp)*r-i,sqrt(n_comp)*c-j)/n_comp;
                        end
                    end
                    for i = 0:(sqrt(n_comp)-1)       % Get in to the average value to compressed image
                        for j = 0:(sqrt(n_comp)-1)  
                            img_comp(sqrt(n_comp)*r-i,sqrt(n_comp)*c-j) = avg;
                        end
                    end
                end
            end
    
        end
        imwrite(img_comp,[num2str(n_comp) '_ img_comp.png']);   % saves the result by the name of the compress ratio
        end
    end
end