% MHI: Takes a directory name for a sequence and returns the MHI

function [H] = computeMHI(directoryName)
    
    depth_image = dir([directoryName, '*.pgm']);
    no_frames = length(depth_image);
    
    % define threshold to remove background
    % define tau which is no. frames of a sequence
    tau = no_frames;
    threshold = 10000;
    
    % name of frame file: 'xxxx.pgm'
    % initialize first frame
    prev_frame = imread([directoryName, depth_image(1).name]);    

    % define D, H matrix
    D = zeros(no_frames, 480, 640, 'uint8');
    H = zeros(no_frames, 480, 640, 'uint8');
    
    for i = 2:no_frames
        
        current_frame = imread([directoryName, depth_image(i).name]);
        diff = abs(prev_frame - current_frame);
        index = diff >= threshold;
        
        % construt D H
        D(i, index) = 255; 
        
        H(i, index) = tau;
        H(i, ~index) = H(i - 1, ~index) - 1;
        
        % update previous frame
        prev_frame = current_frame;
    end
    
    % assign D, H for debugging
%     assignin('base', 'D', D);
%     assignin('base', 'H_original', H);
%     assignin('base', 'H_norm', H);

    %normalize H by max value
    H = double(H);
    H = H(no_frames, :) / max(H(no_frames, :));
    H = reshape(H, 480, 640);
    
end