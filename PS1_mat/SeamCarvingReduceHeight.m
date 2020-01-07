% a for Prague
im = imread('inputSeamCarvingPrague.jpg');
% im = imread('inputSeamCarvingMall.jpg');
reducedColorImage = im;
engy_im = energy_image(im);
reduceEnergyImage = engy_im;

for kk = 1:100
    [reducedColorImage,reduceEnergyImage] = reduceHeight(reducedColorImage, reduceEnergyImage);
    disp(kk)
end
imwrite(reducedColorImage, 'outputReduceHeightPrague.png');
% imwrite(reducedColorImage, 'outputReduceHeightMall.png');
