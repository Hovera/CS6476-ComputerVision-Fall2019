clc;clear;close all;

load('kmeans_centers.mat');
load('BOW.mat');

addpath('sift/');
addpath('frames/');

frame_dir = dir('frames/');
sift_dir = dir('sift/');

sift_dir = sift_dir(3:end);
frame_dir = frame_dir(3:end);

%%

frame_id = 4123;

for i = frame_id
    load(sift_dir(i).name);
    im = imread(frame_dir(i).name);
    region_index = selectRegion(im, positions);

    distances = dist2(kmeans, descriptors(region_index, :));
    [aloha, index] = min(distances);
    for m = 1:size(kmeans, 1)
        ref_BOW(m) = numel(find(index == m));
    end
    ref_BOW = ref_BOW ./ norm(ref_BOW);
end

    distance = dist2(ref_BOW, BOWV);
    [aloha, sorted_index] = sort(distance);
    
    test_frame = 1:4922;
    matched_frame = test_frame(sorted_index(1:6));

    figure;
    subplot(3, 3, 1);
    imshow(imread(frame_dir(i).name)); 
    title(['Original ', num2str(i)]);

    for j = 1 : 6
        subplot(3, 3, j+1);
        imshow(imread(frame_dir(matched_frame(j)).name))
        title(['Similar ', num2str(matched_frame(j))]);
    end


