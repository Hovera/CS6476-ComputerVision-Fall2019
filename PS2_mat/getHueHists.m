function [histEqual, histClustered] = getHueHists(im, k)

    hsvImg = rgb2hsv(double(im));
    r = size(hsvImg,1);
    c = size(hsvImg,2);
    pixel = reshape(double(hsvImg), r * c, 3);
    col = pixel(:,1);
    [index, center] = quantizeHSV(im, k);
    
    figure
    subplot(1,2,1);
    histEqual = histogram(col, k);
    title(['histEqual for k = ', num2str(k)]);
    subplot(1,2,2);
    histClustered = histogram(col, sort(center));
    title(['histClustered for k = ', num2str(k)]);
   
end