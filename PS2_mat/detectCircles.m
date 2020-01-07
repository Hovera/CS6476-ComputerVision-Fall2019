
function [centers] = detectCircles(im, radius, useGradient)

    im = rgb2gray(im);
    edges = edge(im,'Canny');
    row_total = size(im,1);
    col_total = size(im,2);

    % create hough space array with 2 radius padding
    hough_space = zeros(row_total + 2 * radius, col_total + 2 * radius);
    bin = 12;
    threshold = 0.9;

    % transfer edge results and gradients into hough space
    if useGradient == 0
        for i = 1:row_total
            for j = 1:col_total    
                if edges(i, j) == 1
                    for theta = 1:360
                        a = round(j - radius * cos(deg2rad(theta))) + radius;
                        b = round(i + radius * sin(deg2rad(theta))) + radius;
                        hough_space(b, a) = hough_space(b, a) + 1;
                    end 
                end
            end    
        end
    elseif useGradient == 1
        [grad_x, grad_y] = imgradientxy(im);
        [~, dir] = imgradient(grad_x, grad_y);
        for i = 1 : row_total
            for j = 1:col_total
                for theta = 45 + dir(i, j) - 45:dir(i, j)
                    a = floor(j - radius * cos(deg2rad(theta))) + radius;
                    b = floor(i + radius * sin(deg2rad(theta))) + radius;
                    hough_space(b,a) = hough_space(b,a) + 1;
                end        
            end    
        end

    end 

    %{
    figure;
    imagesc(hough_space);
    title(['hough space accumulator array, useGradient = ',...
        num2str(useGradient), ', radius = ', num2str(radius)]);
    %}

    % choose locations and convert to original coordinate
    a = floor(size(hough_space,1) / bin);
    b = floor(size(hough_space,2) / bin);
    a_array = zeros(a,b);
    

    % voting
    for i = 1:a
        for j = 1:b
                vote = hough_space(1 + ((i-1) * bin):i * bin, 1 + ((j-1) * bin):j * bin);
                a_array(i, j)=max(max(vote));      
        end    
    end

    % select locations with higher votes
    [row,col] = find(a_array > threshold * max(max(a_array)));
    centers = zeros(size(row, 1), 2);
    
    % convert coordinates back to original image to display later
    for i = 1:size(row, 1)
       vote = hough_space(1 + ((row(i,1)-1) * bin):row(i,1) * bin, 1+((col(i,1)-1)*bin):col(i,1) * bin); 
       [~, A] = max(vote(:));
       [r, c] = ind2sub(size(vote), A);   
       centers(i,1) = r + (row(i,1) - 1) * bin - radius; 
       centers(i,2) = c + (col(i,1) - 1) * bin - radius;     
    end

end 
