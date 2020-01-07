image = 'cat.jpg';

input = imread('cat.jpg');
n_pair = 4;

h = figure; imshow(image);
image = ginput(4);
close(h);
input_orig = image';

x_max = max(input_orig(1,:)); y_max = max(input_orig(2,:));
x_min = min(input_orig(1,:)); y_min = min(input_orig(2,:));

ref_orig = [1, x_max - x_min, 1,           x_max - x_min;
            1, 1,             y_max - y_min, y_max - y_min];

input_homo = [input_orig; ones(1, n_pair)];
ref_homo = [ref_orig; ones(1, n_pair)];

% computeH
H = computeH(input_orig, ref_orig);
image_warped = H * input_homo;
n_pairs = size(image_warped, 2);
normalized_points = zeros(size(image_warped));
for i = 1:n_pairs
    normalized_points(:,i) = image_warped(:,i)/image_warped(3,i);
end
image_warped = normalized_points;

% warpImage
rectifiedIm = rectifyImg(input, input_homo, H);

% Plots
figure(1);
imshow(input);
hold on;
plot(input_orig(1,:), input_orig(2,:), 'r.', 'MarkerSize', 10);
hold off;
saveas(1, 'gatech_tsrb_homo.png')

figure(2);
imshow(rectifiedIm); 
saveas(2, 'gatech_tsrb_rectified.png')