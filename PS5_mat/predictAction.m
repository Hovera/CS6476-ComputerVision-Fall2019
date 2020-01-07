function [predictedLabel] = predictAction(testMoments, trainMoments, trainLabels)
    
    [N, ~] = size(trainMoments);
    distance_mat = zeros(N, 1);

    % calculate variance for train data
    var_train = nanvar(trainMoments);
    
    % calculate distances
    for i = 1:N
        % formula: https://docs.scipy.org/doc/scipy-0.7.x/reference/spatial.distance.html
        distance_mat(i) = sqrt(sum(((trainMoments(i,:) - testMoments).^2) ./ var_train));
    end
    
    [sorted_dis, sorted_label] = sort(distance_mat);

    % most frequent action labels based on sorted distance matrix's index
    predictedLabel = mode(trainLabels(sorted_label(1:4)));
    
    assignin('base','sorted_label_index', sorted_label);
    
    % for debugging
%     assignin('base', 'distance_mat', distance_mat);
%     assignin('base','sorted_dis', sorted_dis);

end