
image_1 = imread('wdc1.jpg');
image_2 = imread('wdc2.jpg');
%image_1 = imread('1.jpg');
%image_2 = imread('2.jpg');
%image_1 = imread('sparta.jpeg');
%image_2 = imread('trevor.jpeg');

image_1_orig = [0;0]';
image_2_orig = [0;0]';
n_pair = size(image_1_orig, 1);

% 1.1
% Getting correspondences using cpselect
while (n_pair < 4) 
    [image_1_orig, image_2_orig] = cpselect(image_1, image_2, ...
        image_1_orig, image_2_orig, 'Wait', true);
    n_pair = size(image_1_orig, 1);
end

image_1_orig(1,:) = [];
image_2_orig(1,:) = [];
n_pair = n_pair - 1;
image_1_orig = image_1_orig'; %transpose
image_2_orig = image_2_orig';
image_1_homo = [image_1_orig; ones(1, n_pair)];
image_2_homo = [image_2_orig; ones(1, n_pair)];

%1.2 computeH
H = computeH(image_1_orig, image_2_orig);
image_warped = H * image_1_homo;

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
saveas(1, 'wdc1_homo_points.png');
%saveas(1, 'room1_homo_points.png');
%saveas(1, 'sparta_homo_points.png');

figure(2); 
imshow(image_2); 
hold on;
plot(image_2_orig(1,:), image_2_orig(2,:), 'r.', 'MarkerSize',10);
hold off;
saveas(2, 'wdc2_homo_points.png');
%saveas(2, 'room2_homo_points.png');
%saveas(2, 'trevor_homo_points.png');

% 1.3 warpImage 
% for warping wdc and own pic
[warpedIm, mergeIm] = warpImage(image_1, image_2, H);

% for warping frame
% [warpedIm, mergeIm] = warpFrame(image_1, image_2, H);

% Plots
% warped image
figure(3); 
imshow(warpedIm); 
hold on;
plot(image_warped(1,:) + x_offset, image_warped(2,:) + y_offset, 'r.', 'MarkerSize',10);
hold off;
saveas(3, 'wdc_warpIm.png');
%saveas(3, 'room_warpIm.png');
% saveas(3, 'warped_sparta.png')

% mosaic, both images
figure(4);
imshow(mergeIm);
saveas(4, 'wdc_mergeIm.png');
%saveas(4, 'room_mergeIm.png');
hold on;
%plot(image_warped(1,:), image_warped(2,:), 'r.', 'MarkerSize', 10);
hold off;
%saveas(4, 'merged_sparta.png')
