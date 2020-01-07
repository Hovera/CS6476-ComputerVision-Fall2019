% 2(a)
origImg = imread('fish.jpg');

[outPutRGB_k5, meanColors_k5] = quantizeRGB(origImg, 5); %k=5
[outPutRGB_k20, meanColors_k20] = quantizeRGB(origImg, 20); %k=20

% 2(b)
[outPutHSV_k5, meanHues_k5] = quantizeHSV(origImg, 5); %k=5
[outPutHSV_k20, meanHues_k20] = quantizeHSV(origImg, 20); %k=20

figure;
subplot(2,2,1);
imshow(outPutRGB_k5); 
title('QuantizeRGB K=5');

subplot(2,2,2);
imshow(outPutRGB_k20); 
title('QuantizeRGB K=20');

subplot(2,2,3);
imshow(outPutHSV_k5); 
title('QuantizeHSV K=5');

subplot(2,2,4);
imshow(outPutHSV_k20); 
title('QuantizeHSV K=20');

% 2(c)
error_RGB_k5 = computeQuantizationError(origImg, outPutRGB_k5);
error_RGB_k20 = computeQuantizationError(origImg, outPutRGB_k20);
error_HSV_k5 = computeQuantizationError(origImg, outPutHSV_k5);
error_HSV_k20 = computeQuantizationError(origImg, outPutHSV_k20);

% 2(d)
im = imread('fish.jpg');
[histEqual_k5,histClustered_k5] = getHueHists(im, 5);
[histEqual_k20,histClustered_k20] = getHueHists(im, 20);



