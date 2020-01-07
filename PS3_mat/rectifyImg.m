function [rectify] = rectifyImg(inputIm, corners, H)

[input_h, intput_w, ~] = size(inputIm); 
Hinv = inv(H);

warped_corners = H * corners;
n_pairs = size(warped_corners,2);
normalized_pts = zeros(size(warped_corners));
for i=1:n_pairs
    normalized_pts(:,i) = warped_corners(:, i)/warped_corners(3, i);
end
warped_corners = normalized_pts;

x_min = min(warped_corners(1,:)); x_max = max(warped_corners(1,:));
y_min = min(warped_corners(2,:)); y_max = max(warped_corners(2,:));

width = round(x_max - x_min);
height = round(y_max - y_min);

rectify = zeros(height * width, 3, 'uint8');

x_len = 1:width;
y_len = 1:height;
[X,Y] = meshgrid(x_len, y_len);

proj_pts = [X(:)'; Y(:)'; ones(1,numel(X))];
source_pts = Hinv * proj_pts;
n_pairs = size(source_pts,2);
normalized_pts = zeros(size(source_pts));
for i=1:n_pairs
    normalized_pts(:,i) = source_pts(:,i)/source_pts(3,i);
end
source_pts = normalized_pts;
source_pts(3,:,:) = [];

x_coor = round(source_pts(1,:)); y_coor = round(source_pts(2,:));

g = x_coor >= 1 & y_coor >= 1 & x_coor < intput_w & y_coor < input_h;

for i=1:width*height
    if(g(i) == 1) 
        rectify(i,:) = inputIm(y_coor(i), x_coor(i), :);
    end
end

rectify = reshape(rectify, height, width, 3);

end

