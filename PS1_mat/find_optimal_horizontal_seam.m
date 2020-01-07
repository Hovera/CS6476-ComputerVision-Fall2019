function horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap)

    horizontalSeam = zeros(size(cumulativeEnergyMap, 2), 1); % col_no * 1 vector
    [minVal, minIndex] = min(cumulativeEnergyMap(:, end)); % set min index of last col
    horizontalSeam(end) = minIndex;
    
    for j = numel(horizontalSeam)-1:-1:1 
        cum_engy_up = intmax;
        cum_engy_down = intmax;
        cum_engy_center = cumulativeEnergyMap(minIndex, j);
        
        if (minIndex > 1)
            cum_engy_up = cumulativeEnergyMap(minIndex - 1, j);
        end
        if (minIndex < size(cumulativeEnergyMap, 1))
            cum_engy_down = cumulativeEnergyMap(minIndex + 1, j);
        end
        
        cum_array = [cum_engy_up, cum_engy_center, cum_engy_down];
        [value, row] = min(cum_array);
        horizontalSeam(j) = row + minIndex - 2;
        
        % update index of last column
        minIndex = horizontalSeam(j);

   end
end
