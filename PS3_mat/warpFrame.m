function [warpIm, mergeIm] = warpFrame(inputIm, refIm, H)

[input_h, input_w, ~] = size(inputIm); 

corner = [1, 1,       input_w, input_w; 
          1, input_h, 1,       input_h;
          1, 1,       1,       1];  

corner_warp = H * corner;

n_pair = size(corner_warp, 2);
normalized_points = zeros(size(corner_warp));
for i = 1:n_pair
    normalized_points(:,i) = corner_warp(:,i) / corner_warp(3,i);
end

corner_warp = normalized_points;

x_min = min(corner_warp(1,:));
x_max = max(corner_warp(1,:));
y_min = min(corner_warp(2,:));
y_max = max(corner_warp(2,:));

x_offset = ceil(abs(x_min));
y_offset = ceil(abs(y_min));


w = ceil(x_max-x_min);
h = ceil(y_max-y_min);
warpIm = zeros(w * h, 3, 'uint8');

x_len = (x_min):(x_max);
y_len = (y_min):(y_max);
[X,Y] = meshgrid(x_len,y_len);
proj_pts = [X(:)'; Y(:)'; ones(1, numel(X))];

Hinv = inv(H);
source_pts = Hinv * proj_pts;

n_pair = size(source_pts, 2);
normalized_points = zeros(size(source_pts));
for i = 1:n_pair
    normalized_points(:,i) = source_pts(:,i) / source_pts(3,i);
end
source_pts = normalized_points;

source_pts(3,:,:) = [];

x_coor = round(source_pts(1,:));
y_coor = round(source_pts(2,:));

g = x_coor >= 1 & y_coor >= 1 & x_coor < input_w & y_coor < input_h;
for i = 1 : h*w
    if(g(i) == 1) 
        warpIm(i, :) = inputIm(y_coor(i), x_coor(i), :);
    end
end

warpIm = reshape(warpIm, h, w, 3);
assignin('base', 'x_offset', x_offset);
assignin('base', 'y_offset', y_offset);

new_img = zeros(y_offset + h - 1, x_offset +  w - 1, 3, 'uint8');
new_img(y_offset:end, x_offset:end, :) = warpIm;
mergeIm = imfuse(new_img, refIm, 'blend');

end

