% Image 1 
im_1=imread('OwnChoice1.jpg');
reducedColorImage=im_1;

engy_im = energy_image(im_1);
reduceEnergyImage=engy_im;

for i=1:80
    [reducedColorImage,reduceEnergyImage] = reduceWidth(reducedColorImage, reduceEnergyImage);
    [reducedColorImage,reduceEnergyImage] = reduceHeight(reducedColorImage, reduceEnergyImage);
    disp(i)
end

imwrite(reducedColorImage, 'OwnChoice1Reduced.png');

im_resize = imresize(im_1, [470 520]);
imwrite(im_resize, 'OwnChoice1MatResize.png');

% Image 2
im_2=imread('OwnChoice2.jpg');
engy_im = energy_image(im_2);
reducedColorImage=im_2;
reduceEnergyImage=engy_im;

for j=1:150
    [reducedColorImage,reduceEnergyImage] = reduceWidth(reducedColorImage, reduceEnergyImage);
    disp(j)
end

imwrite(reducedColorImage, 'OwnChoice2Reduced.png');

im_resize = imresize(im_2, [533 650]);
imwrite(im_resize, 'OwnChoice2MatResize.png');


% Image 3
im3=imread('OwnChoice3.jpg');
engy_im = energy_image(im3);
reducedColorImage=im3;
reduceEnergyImage=engy_im;

for k=1:150
    [reducedColorImage,reduceEnergyImage] = reduceHeight (reducedColorImage, reduceEnergyImage);
    disp(k)
end

imwrite(reducedColorImage, 'OwnChoice3Reduced.png');

im_resize = imresize(im_3, [233 500]);
imwrite(im_resize, 'OwnChoice3MatResize.png');

