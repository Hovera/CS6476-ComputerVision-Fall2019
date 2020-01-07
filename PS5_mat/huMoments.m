function [moments] = huMoments(H)
    [height, width] = size(H);
    
    row = [1:height]';
    col = [1:width];
    
    M_00 = sum(H, 'all');
    M_01 = 0.0;
    M_10 = 0.0;
    
    % Calculate M_01 and M_10
    for x = 1:length(col)
        for y = 1:length(row)
            M_01 = y * H(y,x) + M_01;
            M_10 = x * H(y,x) + M_10;            
        end
    end
    
    x_mean = M_10 / M_00;
    y_mean = M_01 / M_00;

    row = row - y_mean;
    col = col - x_mean;

    row_0 = 1;
    row_1 = row;
    row_2 = row .^ 2;
    row_3 = row .^ 3;
    
    col_0 = 1;
    col_1 = col;
    col_2 = col .^ 2;
    col_3 = col .^ 3;
   
    mu_02 = sum(sum(bsxfun(@times,(row_2 * col_0), H)));
    mu_20 = sum(sum(bsxfun(@times, (row_0 * col_2), H)));
    
    mu_03 = sum(sum(bsxfun(@times,(row_3 * col_0 ), H)));
    mu_30 = sum(sum(bsxfun(@times, (row_0 * col_3 ), H)));
    
    mu_11 = sum(sum((row_1 * col_1 ) .* H));
    
    mu_12 = sum(sum((row_2 * col_1) .* H));
    mu_21 = sum(sum((row_1 * col_2) .* H));
    
    h1 = mu_20 + mu_02;
    
    h2 = (mu_20 - mu_02)^2 + (4*mu_11)^2;
    
    h3 = (mu_30 - 3*mu_12)^2 +(3*mu_21 - mu_03)^2;
    
    h4 = (mu_30 + mu_12)^2 + (mu_21 + mu_03)^2;
    
    h5 = (mu_30 - 3*mu_12) * (mu_30 + mu_12) * ((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2)...
        + (3*mu_21 - mu_12) * (mu_21 + mu_03) * (3*(mu_30 + mu_12)^2 - (mu_21 + mu_03)^2);
    
    h6 = (mu_20 - mu_02) * ((mu_30 + mu_12)^2 - (mu_21 + mu_03)^2)...
        + 4 * mu_11 * (mu_30 + mu_12) * (mu_21 + mu_03);
    
    h7 = (3 * mu_21 - mu_03) * (mu_30 + mu_12) * ((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2)...
        - (mu_30 - 3 * mu_12) * (mu_21 + mu_03) * (3*(mu_30+mu_12)^2 - (mu_21 + mu_03)^2);
    
    moments = [h1, h2, h3, h4, h5, h6, h7];



end