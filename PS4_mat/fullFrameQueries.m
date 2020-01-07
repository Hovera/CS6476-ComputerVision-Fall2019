clc;clear;close all;

load('kmeans_centers.mat');

addpath('sift/');
addpath('frames/');

frame_dir = dir('frames/');
sift_dir = dir('sift/');

sift_dir = sift_dir(3:end);
frame_dir = frame_dir(3:end);

K = size(kmeans, 1);
BOW = zeros(size(sift_dir,1), K);
bin = 1:K; 

for i = 1:size(sift_dir,1)
    
    load(sift_dir(i).name);
    no_feature = size(descriptors,1);
    
    if ( no_feature ~= 0)
       distance = dist2(kmeans,descriptors);
       [aloha, index] = min(distance);
       bin_counts= histc(index, bin);
       BOW(i,:) = bin_counts;     
    end
end

for i = 1 : size(sift_dir, 1)
    BOWV(i,:)=BOW(i,:) / norm(BOW(i,:));
end

save('BOW.mat','BOW','BOWV');

 
 %%
 % find similar frames
 for im_id = [668, 1000, 4377]
     
     temp_mat = zeros(size(sift_dir, 1), 1); 
     
     for i = 1 : size(sift_dir, 1)
          temp_mat(i) = dot(BOWV(im_id, :), BOWV(i, :));
     end
 
     dot_mat = zeros(5, 1);
     temp_mat(im_id) = 0;
     
     for i = 1:5
         [aloha, dot_mat(i)] = max(temp_mat);
         temp_mat(dot_mat(i)) = 0;
     end
 
     figure;
     subplot(2, 3, 1);
     imshow(imread(frame_dir(im_id).name)); 
     title(['Original Frame No. ', num2str(im_id)]);
 
     for i = 1:5
         subplot(2, 3, i+1);
         imshow(imread(frame_dir(dot_mat(i)).name));
         title(['Similar Frame: No. ', num2str(dot_mat(i))]);
     end
 end
 