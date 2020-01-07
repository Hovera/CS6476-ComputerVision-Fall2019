
function H = computeMHI_depth(directoryName)

    depth_image = dir([directoryName, '*.pgm']);
    no_frames = length(depth_image);
    
    % define threshold to remove background
    % define tau which is no. frames of a sequence
    tau = no_frames;
    threshold = 50000;
    
    prev_frame = imread([directoryName, depth_image(1).name]);   
    
    prev_frame = prev_frame > threshold;
    

    % define D, H matrix
    D = zeros(no_frames, 480, 640, 'uint8');
    H = zeros(no_frames, 480, 640, 'uint8');

    for i = 2:no_frames      

        depth = imread([directoryName, depth_image(i).name]);
        depth = depth > threshold;
        
        diff = min(prev_frame, depth);
        index = ~diff;
        
        % construt D H
        D(i, index) = 255; 
        H(i, index) = tau;
        H(i, ~index) = H(i - 1, ~index) - 1;
        
        % update previous frame
        prev_frame = depth;

    end
    
    H = double(H);
    H = H(no_frames, :) / max(H(no_frames, :));
    H = reshape(H, 480, 640);
end

