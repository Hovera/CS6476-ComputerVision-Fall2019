function energyImage = energy_image(im)
  
    %convert to grayscale
    gray = rgb2gray(im);
    
    %convert to double
    double_im = double(gray);
    
    % filter_y = fspecial('laplacian');
    % filter_x = filter_y.';
    
    % calculate gradient and energy
    [x_grad, y_grad] = gradient(double_im);
    
    % x_grad = imfilter(double_im, filter_x);
    % y_grad = imfilter(double_im, filter_y);
    
    energyImage = sqrt(x_grad.^2 + y_grad.^2);
end