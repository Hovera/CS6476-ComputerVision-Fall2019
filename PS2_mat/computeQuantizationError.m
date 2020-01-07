function [error] = computeQuantizationError(origImg,quantizedImg)
   
    diff = (origImg - quantizedImg).^2; 
    error = sum(sum(sum(diff)));
   
end
