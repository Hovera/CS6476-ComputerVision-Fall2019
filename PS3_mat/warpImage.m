function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)
% warpIm, which is the input image inputIm warped according to H 
% to be in the frame of the reference image refIm. 
% mergeIm, a single mosaic image with a larger field of view containing 
% both the input images. 

Hinv = inv(H);
[ref_h, ref_w, ~] = size(refIm); 
[input_h, input_w, ~] = size(inputIm); 

corner = [1, 1,       input_w, input_w; 
          1, input_h, 1,       input_h;
          1, 1,       1,       1];  

% warp by applying H
corner_warp = H * corner;

% normalize homo matrix
n_pair = size(corner_warp, 2);
normalized_points = zeros(size(corner_warp));
for i = 1:n_pair
    normalized_points(:,i) = corner_warp(:,i) / corner_warp(3,i);
end
corner_warp = normalized_points;

x_min = min(corner_warp(1,:)); y_min = min(corner_warp(2,:));
x_max = max(corner_warp(1,:)); y_max = max(corner_warp(2,:));
x_offset = 1; y_offset = 1;

if(y_min < 1)
    y_offset = round(abs(y_min));
end

if(x_min < 1)
    x_offset = round(abs(x_min));
end

w = ceil(x_max - x_min); h = ceil(y_max - y_min);

x_len = x_min:x_max; y_len = y_min:y_max;
[X, Y] = meshgrid(x_len,y_len);

proj_pt = [X(:)'; Y(:)'; ones(1, numel(X))];
source_pt = Hinv * proj_pt;
n_pair = size(source_pt, 2);

normalized_points = zeros(size(source_pt));
for i = 1:n_pair
    normalized_points(:,i) = source_pt(:,i) / source_pt(3,i);
end
source_pt = normalized_points;
source_pt(3,:,:) = [];

x_coor = round(source_pt(1,:));
y_coor = round(source_pt(2,:));

warpIm = zeros(h * w, 3, 'uint8');

g = x_coor >= 1 & y_coor >= 1 & x_coor < input_w & y_coor < input_h;
for i = 1 : h*w
    if(g(i) == 1) 
        warpIm(i, :) = inputIm(y_coor(i), x_coor(i), :);
    end
end

warpIm = reshape(warpIm, h, w, 3);

assignin('base', 'x_offset', x_offset);
assignin('base', 'y_offset', y_offset);

new_img = zeros(ref_h + y_offset - 1, ref_w + x_offset - 1, 3, 'uint8');
new_img(y_offset:end, x_offset:end, :) = refIm;
mergeIm = imfuse(warpIm, new_img * 1.8, 'blend');

end
