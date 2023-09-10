
%{
The script is designed to add Gaussian noise to the image
and create a noise mask for the image by the SNR
%}

classdef Noise_adder % Add a class to use from other functions
    methods

        
        function Noise_img(obj,img,SNR) % get the image and the SNR
        %{
        The function get an image and SNR and adding a gaussian noise to image by the SNR.
        When the SNR is big, the effect of noise on the image is small.
        the function save the new noiesy image to memory by the SNR name.
        %}
            img = rgb2gray(img);        % Convert to gray
            img = uint16(img);          % Convert to 16-bit unsigned integer in order to not lose values
            rows = size(img,1);         % Take the matrix length 
            columns  = size(img,2);
            noise_img= uint8(zeros(rows, columns));                     % Create a new matrix for the new image
            signal_energy = sum(uint16(img).^2,'all')/(rows*columns);   % Calculate the image energy by Random process theory
            noise_var = sqrt(signal_energy/SNR);                        % Calculate the image variance by energy
            

            for r = 1:rows           % Loop the rows and columns to add a noise
                for c = 1:columns
                        noise_img(r,c)=img(r,c)+normrnd(0,noise_var);   % Addind a random gaussian noize to every pixel
                end
            end
            imwrite(noise_img,[num2str(SNR) '_ SNR_img.png']); % saves the result by the value name of the SNR
        end


        function Noise_mask(obj,img,SNR)
        %{
        The function get an image and SNR creating a gaussian 
        noise mask by the SNR.
        %}
            img = rgb2gray(img);        % Convert to gray
            img = uint16(img);          % Convert to 16-bit unsigned integer in order to not lose values
            rows = size(img,1);         % Take the matrix length 
            columns  = size(img,2);
            noise_mask= uint8(zeros(rows, columns));                    % Create a new matrix for mask
            signal_energy = sum(uint16(img).^2,'all')/(rows*columns);   % Calculate the image energy by Random process theory
            noise_var = sqrt(signal_energy/SNR);                        % Calculate the image variance by energy
            for r = 1:rows           % Loop the rows and columns to create the mask noise
                for c = 1:columns
                        noise_mask(r,c)=normrnd(0,noise_var);   % Addind a random gaussian noize to every pixel
                end
            end
            imwrite(noise_mask,[num2str(SNR) '_ SNR_noise_mask.png']); % saves the result by the value name of the SNR
        end
    end
end