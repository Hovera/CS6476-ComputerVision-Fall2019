function [outputImg, meanHues] = quantizeHSV(origImg, k)

    outputImg = zeros(size(origImg));
    hsv_im = rgb2hsv(double(origImg));
    r = size(origImg, 1);
    c = size(origImg, 2);

    pixel = reshape(hsv_im, r * c, 3);

    [index,center] = kmeans(pixel(:, 1), k);
    meanHues = center;

    index_matrix = reshape(index, r, c);

    for i = 1:r
        for j = 1:c
            value = index_matrix(i, j);
            outputImg(i,j,1) = center(value);
        end
    end
    
    outputImg(:,:,2) = hsv_im(:,:,2);
    outputImg(:,:,3) = hsv_im(:,:,3);
    
    outputImg = uint8(hsv2rgb(double(outputImg)));
    

end

