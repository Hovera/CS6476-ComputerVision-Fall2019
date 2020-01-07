function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)

    verticalSeam = zeros(size(cumulativeEnergyMap, 1), 1); % row_no * 1 vector
    [minVal, minIndex] = min(cumulativeEnergyMap(end, :)); % set min index of last row
    verticalSeam(end) = minIndex;

    for i = numel(verticalSeam)-1:-1:1 % trace back from last 2nd row to first row 
        cum_engy_left = intmax;
        cum_engy_right = intmax;
        cum_engy_center = cumulativeEnergyMap(i, minIndex);
        
        if (minIndex > 1) % if not first column
            cum_engy_left = cumulativeEnergyMap(i, minIndex - 1);
        end
        if (minIndex < size(cumulativeEnergyMap, 2)) % if not last column
            cum_engy_right = cumulativeEnergyMap(i, minIndex + 1);
        end
        
        cum_array = [cum_engy_left, cum_engy_center, cum_engy_right];  
        [value, col] = min(cum_array);
        verticalSeam(i) = col + minIndex - 2;
        
        % update index of last row
        minIndex = verticalSeam(i);

   end
end
