clc;clear;close all;

load('kmeans_centers.mat');
load('BOW.mat');

addpath('sift/');
addpath('frames/');
frame_dir = dir('frames/');
sift_dir = dir('sift/');
sift_dir = sift_dir(3:end);
frame_dir = frame_dir(3:end);

frame_id = 904;
k = 1500;
bin = 1:k; 

%%
% tf-idf

n_i = zeros(k,1);

for i = 1:size(sift_dir, 1)
   for j = 1 : k
       if BOW(i, j) >0
           n_i(j) = n_i(j) + 1;
       end    
   end    
end

for i = 1:k
    n_i(i) = log(size(sift_dir, 1)/n_i(i));
    if n_i(i) == Inf
        n_i(i) = 0;
    end    
end    

for i = 1:size(sift_dir, 1)
   n_d = sum(BOW(i, :));
   for j = 1:k
       BOW(i,j) = BOW(i,j) * n_i(j) / n_d;
   end
end

for i = 1:size(sift_dir, 1)
    BOWV(i, :) = BOW(i, :) ./ norm(BOW(i, :)); 
end

%%
load(sift_dir(frame_id).name);
im = imread(frame_dir(frame_id).name);
region_index = selectRegion(im, positions);
  
temp = dist2(kmeans, descriptors(region_index,:));
[aloha, index] = min(temp); 
ref_BOW = histc(index, bin);

n_d = sum(ref_BOW);
for j = 1 : k
    ref_BOW(j) = ref_BOW(j) * n_i(j) / n_d;
end

ref_BOW = ref_BOW ./ norm(ref_BOW);

%%

temp = zeros(size(sift_dir, 1), 1); 
for i = 1:size(sift_dir, 1) 
    temp(i) = dot(ref_BOW, BOWV(i,:));
end

dot_mat = zeros(5, 1);
temp(frame_id) = 0;
aloha = zeros(5,1);

for i = 1:5
   [aloha(i), dot_mat(i)] = max(temp);
   temp(dot_mat(i)) = 0;
end

%%
figure;
subplot(2, 3, 1);
imshow(im);
title(['Original ', num2str(frame_id)]);

for i = 1:5
    subplot(2, 3, i+1);
    imshow(imread(frame_dir(dot_mat(i)).name))
    title(['Similar ',num2str(dot_mat(i))]);
end
