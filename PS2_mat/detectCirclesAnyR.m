
im = rgb2gray(imread('egg.jpg'));
useGradient = 1;
edges = edge(im,'Canny');
row_total = size(im,1);
col_total = size(im,2);

% define max radius and min radius of possible circles
max_radius = 9;
min_radius = 3;
% increase hough space into 3d
hough_space = zeros(row_total + 2 * max_radius, col_total + 2 * max_radius, max_radius);
bin = 2;
threshold = 0.9;

for radius = min_radius:max_radius  % add for loop for each radius
    if useGradient == 0
        for i = 1:row_total
            for j = 1:col_total    
                if edges(i, j) == 1
                    for theta = 1:360
                        a = radius + round(j - radius * cos(deg2rad(theta)));
                        b = radius + round(i + radius * sin(deg2rad(theta)));
                        hough_space(b, a) = hough_space(b, a) + 1;
                    end 
                end
            end    
        end
    elseif useGradient == 1
        [grad_x, grad_y] = imgradientxy(im);
        [~, dir] = imgradient(grad_x, grad_y);
        for i = 1:row_total
            for j = 1:col_total
                for theta = dir(i, j) - 45:dir(i, j) + 45
                    a = radius + floor(j - radius * cos(deg2rad(theta)));
                    b = radius + floor(i + radius * sin(deg2rad(theta)));
                    hough_space(b,a) = hough_space(b,a) + 1;
                end        
            end    
        end
    end
end 

a = floor(size(hough_space,1) / bin);
b = floor(size(hough_space,2) / bin);
accumulator_array = zeros(a,b,max_radius); % add dimension 
centers = zeros(a,b,max_radius); %add dimension  ??

% add for loop for each radius
for radius = min_radius:max_radius
    for i = 1:a
        for j = 1:b
             A = hough_space(1 + ((i-1) * bin):i * bin, 1 + ((j-1) * bin):j * bin, radius);
             accumulator_array(i, j, radius)=max(max(A));      
        end    
    end

    [row,col]=find(accumulator_array(:,:,radius) > threshold * max(max(max(accumulator_array))));

    for i = 1:size(row, 1)
       A = hough_space(1 + ((row(i,1)-1) * bin):row(i,1) * bin, 1+((col(i,1)-1)*bin):col(i,1) * bin); 
       [~, B] = max(A(:));
       [r, c] = ind2sub(size(A), B);   
       centers(i,1) = (row(i,1)-1) * bin + r - radius; 
       centers(i,2) = (col(i,1)-1) * bin + c - radius;  
       centers(i,3) = radius;
    end
end

%{
figure;
imagesc(hough_space);
title(['hough space accumulator array, useGradient = ',...
    num2str(useGradient), ', radius = ', num2str(radius)]);
%}

%{
figure;   
imshow(im);
for i = 1:size(centers,1)
theta = 0:pi / 50:2*pi;
% x = ??
% y = ??
hold on
plot(x, y, 'G','LineWidth',2);
end
title('multi-radius circle detection');    
%}