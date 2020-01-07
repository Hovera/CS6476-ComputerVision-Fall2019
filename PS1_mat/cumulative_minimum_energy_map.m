function cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage,seamDirection)
    
    cumulativeEnergyMap=ones(size(energyImage));

    % seamDirection can be "VERTICAL" or "HORIZONTAL"
    if strcmp(seamDirection, 'VERTICAL') == 1
        cumulativeEnergyMap(1,:) = energyImage(1,:); % copy first row of pixels
        for i = 2:size(cumulativeEnergyMap, 1) %start from second row and first column
            for j = 1:size(cumulativeEnergyMap, 2) 
                cum_energy_left = intmax; % set them to the biggest value for comparison later
                cum_energy_right = intmax;
                cum_energy_center = cumulativeEnergyMap(i - 1, j);
                % if we are at the first column, we don't need to calculate j - 1
                if (j > 1) 
                    cum_energy_left = cumulativeEnergyMap(i - 1, j - 1);
                end
                
                % if we are at the last column, we don't need to calculate j + 1
                if (j < size(cumulativeEnergyMap, 2)) 
                    cum_energy_right = cumulativeEnergyMap(i - 1, j + 1);
                end
                % recursive calculations
                cumulativeEnergyMap(i, j)= energyImage(i, j)+ min(cum_energy_center, min(cum_energy_left, cum_energy_right));
            end
        end
    else    
        cumulativeEnergyMap(:, 1)=energyImage(:, 1); % copy first column of pixels
        for j = 2:size(energyImage, 2) %start from second column and first row
            for i = 1:size(energyImage, 1) 
                cum_energy_up = intmax;
                cum_energy_down = intmax;
                cum_energy_center = cumulativeEnergyMap(i, j - 1);
                if (i > 1)
                    cum_energy_up = cumulativeEnergyMap(i - 1, j - 1);
                end
                
                if (i < size(cumulativeEnergyMap, 1))
                   cum_energy_down = cumulativeEnergyMap(i + 1, j - 1); 
                end
                cumulativeEnergyMap(i, j)= energyImage(i, j)+ min(cum_energy_center, min(cum_energy_up, cum_energy_down));              
            end
        end    
    end 
end