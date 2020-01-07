function displaySeam(im, seam, type)
    figure,
    imshow(im);
    hold on;
    if strcmp(type, 'VERTICAL') == 1
        plot(seam, 1:numel(seam))
    else
        plot(1:numel(seam), seam)
    end
end