clc; clear all; close all;

load HuVectors

k = 4;
trainLabels = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5];
confusion_matrix = zeros(5, 5);
action = { 'botharms', 'crouch', 'leftarmup', 'punch', 'rightkick'};
sequence = {'-p1-1', '-p1-2', '-p2-1', '-p2-2'};

% LOO-CV
for i = 1:20
    
    [sequence_no, action_no] = ind2sub([4, 5], i);
    
    trainMoment = huVectors;
    trainMoment(i, :) = NaN;
    trainLabels_copy = trainLabels;
    trainLabels_copy(:, i) = NaN;

    predictedLabel = predictAction(huVectors(i, :), trainMoment, trainLabels_copy);

    confusion_matrix(action_no, predictedLabel) = confusion_matrix(action_no, predictedLabel) + 1;
    
end

%% Compute recognition rate

correct_label_all = 0; 
mean_rate = 0;

for i = 1:5
    
   correct_label_all = confusion_matrix(i, i) + correct_label_all;
   overall_rate = correct_label_all / 20;
   
   class_rate = confusion_matrix(i, i) / 4;
   S = sprintf('Recognition Rate for %s: %.2f\n', action{i}, class_rate);
   disp(S);
   mean_rate = mean_rate + class_rate;

end

mean_rate = mean_rate / 5;

fprintf('Overall Recognition Rate: %.2f\n', overall_rate);
fprintf('Mean Recognition Rate per Class: %.2f\n', mean_rate);

disp('Confusion Matrix: ');
disp(confusion_matrix);
