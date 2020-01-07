% Compute MHI for all data

clc; clear all; close all;

action = { 'botharms', 'crouch', 'leftarmup', 'punch', 'rightkick'};
no_actions = length(action);

sequence = {'-p1-1', '-p1-2', '-p2-1', '-p2-2'};
no_seq = length(sequence);
counter = 1;

% initialize empty all_H
allMHIs = zeros(480,640,20);

%{
% create directory to save MHI images

if ~exist('MHI', 'dir')
	mkdir MHI
end

% for extra credit
if ~exist('MHI_depth', 'dir')
	mkdir MHI_depth
end
%}


for i = 1:no_actions

    for j = 1:no_seq
        
        % naming of boatharms and leftarmup sequence folder is slightly different 
        if strcmp(action{i}, 'botharms') == 1
            path_seq = ['PS5_Data/', action{i}, '/', 'botharms-up', sequence{j}, '/'];
        elseif strcmp(action{i}, 'leftarmup') == 1
            path_seq = ['PS5_Data/', action{i}, '/', 'leftarm-up', sequence{j}, '/'];
        else
            path_seq = ['PS5_Data/', action{i}, '/', action{i}, sequence{j}, '/'];
        end
        
%         H = computeMHI_mean(path_seq);  % for extra credit
%         H = computeMHI_depth(path_seq); % for extra credit
        H = computeMHI(path_seq);
        allMHIs(:, :, counter) = H;
        counter = counter + 1;
        
        % Plot and save figure
        
        figure(counter); 
        imagesc(H); 
        title(['Action: ', action{i}, ' Sequence: ', sequence{j}]);
%         saveas(counter, ['MHI_depth/', action{i}, sequence{j}, '.png'],'png');
        saveas(counter, ['MHI/', action{i}, sequence{j}, '.png'],'png');
        
        
    end

end

save allMHIs