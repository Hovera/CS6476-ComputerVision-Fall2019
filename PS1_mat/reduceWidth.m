function [reducedColorImage,reducedEnergyImage] = reduceWidth(im, energyImage)
    
    reducedColorImage = zeros(size(im,1), size(im,2)-1, 3); % color image

    cum_engy_map = cumulative_minimum_energy_map(energyImage, 'VERTICAL');
    vertical_seam = find_optimal_vertical_seam(cum_engy_map);

    for row = 1:size(im, 1)
        for col = 1 : vertical_seam(row) - 1
            reducedColorImage(row, col, :) = im(row, col, :);
        end
        for col = vertical_seam(row): size(im, 2) - 1
            reducedColorImage(row, col, :) = im(row, col+1, :);
        end
    end
    reducedColorImage = uint8(reducedColorImage); % convert to uint8 format
    reducedEnergyImage = energy_image(reducedColorImage);
end