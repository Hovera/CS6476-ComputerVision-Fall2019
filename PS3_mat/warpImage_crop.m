image_1 = imread('crop1.jpg');
image_2 = imread('crop2.jpg');

% 1.1
load('cc1.mat');
load('cc2.mat');

image_1_orig = cc1';
image_2_orig = cc2';
n_pair = size(image_1_orig, 1);

image_1_orig = image_1_orig'; %transpose
image_2_orig = image_2_orig';
image_1_homo = [image_1_orig; ones(1, n_pair)];
image_2_homo = [image_2_orig; ones(1, n_pair)];


% 1.2 computeH
H = computeH(image_1_orig, image_2_orig);
image_warped = H * image_1_homo;

% normalize homo matrix, [uw,vw,w] to [u,v,1]
n_pairs = size(image_warped, 2);
normalized_points = zeros(size(image_warped));
for i = 1:n_pairs
    normalized_points(:,i) = image_warped(:,i)/image_warped(3,i);
end
image_warped = normalized_points;

% plot homo points on images 1 and 2
figure(1); 
imshow(image_1); 
hold on;
plot(image_1_orig(1,:), image_1_orig(2,:), 'r.', 'MarkerSize',10);
hold off;
saveas(1, 'crop1_homo_points.png');

figure(2); 
imshow(image_2); 
hold on;
plot(image_2_orig(1,:), image_2_orig(2,:), 'r.', 'MarkerSize',10);
hold off;
saveas(2, 'crop2_homo_points.png');

% 1.3 warpImage 
[warpedIm, mergeIm] = warpImage(image_1, image_2, H);

% Plotting
% warped image
figure(3); 
imshow(warpedIm); 
hold on;
plot(image_warped(1,:) + x_offset, image_warped(2,:) + y_offset, 'r.', 'MarkerSize',10);
hold off;
saveas(3, 'crop_warpIm.png');

% mosaic, both images
figure(4);
imshow(mergeIm);
saveas(4, 'crop_mergeIm.png');