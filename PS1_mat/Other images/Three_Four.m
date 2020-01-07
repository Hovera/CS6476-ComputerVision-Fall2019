% 3 (a)
im = imread('inputSeamCarvingPrague.jpg');
engy_im = energy_image(im);
figure
imagesc(engy_im);

%3 (b)
cum_engy_map_vertical = cumulative_minimum_energy_map(engy_im,'VERTICAL');
cum_engy_map_horizontal = cumulative_minimum_energy_map(engy_im,'HORIZONTAL');
figure
imagesc(cum_engy_map_vertical);

figure 
imagesc(cum_engy_map_horizontal);

% 4 (a)
horizontal_seam = find_optimal_horizontal_seam(cum_engy_map_horizontal);
displaySeam(im, horizontal_seam, 'HORIZONAL');

% 4 (b)
vertical_seam = find_optimal_vertical_seam(cum_engy_map_vertical);
displaySeam(im, vertical_seam, 'VERTICAL');


