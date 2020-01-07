clc; close all; clear all;

%build vocabulary
addpath('sift/');
addpath('frames/');

frame_dir = dir('frames/');
sift_dir = dir('sift/');

sift_dir = sift_dir(3:end);
frame_dir = frame_dir(3:end);

% create empty matrices
desc_mat = [];
position_mat = [];
scale_mat = [];
orient_mat = [];
im_id = [];

% loop through sift files/frames, build essential matrices
for i = 1:size(sift_dir, 1)
    
    load(sift_dir(i).name);
    
    if size(descriptors, 1) < 30
        sample_desc = size(descriptors, 1);
    else
        sample_desc = 30;
    end
    
    index = randperm(sample_desc);
    
    desc_mat = [desc_mat; descriptors(index, :)];
    position_mat = [position_mat; positions(index, :)];
    scale_mat = [scale_mat; scales(index, :)];
    orient_mat = [orient_mat; orients(index, :)];
    im_id(end+1 : end+sample_desc) = i;
    
end

% use kmeansML to get clusters of visual words
n_clusters = 1500;
[membership, kmeans, rms] = kmeansML(n_clusters, desc_mat');
kmeans = kmeans';

% save kmeans_centers.mat kmeans
% save kmeans.mat membership kmeans position_mat scale_mat orient_mat im_id

%% Load some centers and show 25 patches

% choose kmeans centers (400, 668, 1268 th word in vocabulary)
words_list = [400, 668, 1268];

for i = words_list
    
    no_patches = 0;
    match_index = [];    
    figure;
    
    % loop through all frames
    for j = 1:size(sift_dir, 1)
        
        load(sift_dir(j).name);
        
        distance = dist2(kmeans, descriptors);
   
        [aloha, min_index] = min(distance);
        
        match_index = find(min_index == i);
        
        for k  = match_index

            image = imread(imname);
            patch = getPatchFromSIFTParameters(positions(k,:), scales(k), ...
                orients(k), rgb2gray(image));
            
            no_patches = no_patches + 1;
            subplot(5, 5, no_patches);
            imshow(patch);
            
            if no_patches == 25
                break;
            end
        end
        
        if no_patches == 25
            break;
        end
    end
end
