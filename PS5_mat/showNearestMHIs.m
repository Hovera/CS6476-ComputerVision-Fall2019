clc; clear all; close all;

%% Calculate Hu moments

% The part to compute all MHIs is in gerenerateAllMHIS.m, so here we just
% start from calculating Hu moments.

load allMHIs

huVectors = zeros(20, 7);

% 20 sequences in total
for i = 1:20
   huVectors(i, :) = huMoments(allMHIs(:, :, i));
end

save huVectors

%% kNN and Plot

% index 13 is one of the punch sequences
% index 2 is one of the botharmsup sequences

test_index = [2, 13];
trainLabels = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5];
K = 4;

action = { 'botharms', 'crouch', 'leftarmup', 'punch', 'rightkick'};
sequence = {'-p1-1', '-p1-2', '-p2-1', '-p2-2'};

for i = test_index
    
    % create training dataset and label
    trainMoment = huVectors;
    trainMoment(i, :) = NaN;
    
    trainLabels_copy = trainLabels;
    trainLabels_copy(:, i) = NaN;

    predictedLabel = predictAction(huVectors(i, :), trainMoment, trainLabels_copy);

    % Plot
    [test_sequence_no, test_action_no] = ind2sub([4, 5], i);

    figure('position', [0, 0, 800, 1300]); 
    subplot(3,2,1); 
    imagesc(allMHIs(:, :, i)); 
    title(['Test action: ', action{test_action_no}, ' Sequence: '...
            num2str(test_sequence_no)]);

    for j = 1:K
        [sequence_no, action_no] = ind2sub([4, 5], sorted_label_index(j));
        subplot(3, 2, j + 2);
        imagesc(allMHIs(:, :, sorted_label_index(j)));
        title(['(Nearest:', num2str(j), ') Action: ', action{action_no},...
            ' Sequence: ', num2str(sequence_no)]);

    end

    saveas(gcf, ['Match Result for ', action{test_action_no}, sequence{test_sequence_no}, '.png']);

end