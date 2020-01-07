function [outputImg, meanColors] = quantizeRGB(origImg, k)
    
    r = size(origImg,1);
    c = size(origImg,2);
    d = size(origImg,3);

    outputImg = zeros(r, c, 3); 
   
    pixel = reshape(double(origImg), r * c, d);
    
    [index, center] = kmeans(pixel, k);

    meanColors = center;
    
    index_matrix = reshape(index, r, c);

    
    % put center value back into each pixel
    for i = 1:r
        for j = 1:c
            value = index_matrix(i,j);
            outputImg(i,j,1) = center(value,1);
            outputImg(i,j,2) = center(value,2);
            outputImg(i,j,3) = center(value,3);
        end
    end

    outputImg = uint8(outputImg);
    
end