function [reducedColorImage,reducedEnergyImage] = reduceHeight(im, energyImage)
    
    reducedColorImage = zeros(size(im, 1) - 1, size(im, 2), 3); % color image

    cum_engy_map = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
    horizontal_seam = find_optimal_horizontal_seam(cum_engy_map);

    for col = 1:size(im, 2)
        for row = 1 : horizontal_seam(col) - 1
            reducedColorImage(row, col, :) = im(row, col, :);
        end
        for row = horizontal_seam(col): size(im, 1) - 1
            reducedColorImage(row, col, :) = im(row+1, col, :);
        end
    end
    reducedColorImage = uint8(reducedColorImage); % convert to uint8 format
    reducedEnergyImage = energy_image(reducedColorImage);
end