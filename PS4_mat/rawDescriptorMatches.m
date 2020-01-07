load('twoFrameData.mat');

indices = selectRegion(im1, positions1);
title('Original');

distance = dist2(descriptors1(indices,:), descriptors2);

distance = min(distance);

index_match = find(distance < 0.2);

figure;
imshow(im2);
title('With Descriptors');
displaySIFTPatches(positions2(index_match, :), scales2(index_match), orients2(index_match), im2);