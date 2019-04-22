function [newPhoto] = projectPoint(H,playerPhoto, gamePhoto)
%PROJECTPOINT Summary of this function goes here
%   Detailed explanation goes here
[pHeight,pWidth] = size(playerPhoto);
newPhoto = gamePhoto;
for i = 1:pHeight
    for j = 1:pWidth
        d = H*[i;j;1];
        d = round(d./d(3));
        
        if d(1) > 0 & d(2) > 0 & d(1) < size(gamePhoto, 1) & d(2) < size(gamePhoto, 2)
            newPhoto(d(1),d(2)) = playerPhoto(i,j);
    end
end
end

