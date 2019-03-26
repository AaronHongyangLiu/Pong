function gray = RGBarray2gray(RGBarray)
    gray = zeros([size(RGBarray, 1), size(RGBarray, 2), size(RGBarray, 4)], 'double');
    for i = 1:size(RGBarray, 4)
        gray(:,:,i) = im2double(rgb2gray(RGBarray(:,:,:,i)));
    end
end