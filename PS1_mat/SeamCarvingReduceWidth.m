
% a 
im = imread('inputSeamCarvingPrague.jpg');
reducedColorImage = im;

% b 
engy_im = energy_image(im);
reduceEnergyImage = engy_im;

for k = 1:100
    [reducedColorImage,reduceEnergyImage] = reduceWidth(reducedColorImage, reduceEnergyImage);
    disp(k) % is for tracking iterations and time
end

% c
imwrite(reducedColorImage, 'outputReduceWidthPrague.png');

% d repeat a-c for mall picture
im = imread('inputSeamCarvingMall.jpg');
reducedColorImage = im;
engy_im = energy_image(im);
reduceEnergyImage = engy_im;

for k = 1:100
    [reducedColorImage,reduceEnergyImage] = reduceWidth(reducedColorImage, reduceEnergyImage);
    disp(k)
end
imwrite(reducedColorImage, 'outputReduceWidthMall.png');
