%% taking player photos, in this test, we are only using photo1
[photo1,photo2] = takingPhoto();

%% get the initial position of the 5 tracked points
I = im2double(rgb2gray(imread('test.jpg')));
% these are some test points on the palm of test.jpg
p1 = [265,972];
p2 = [436,883];
p3 = [548,954];
p4 = [433,1082];
p5 = [471,1006];

%% calculate the corrisponding point on the player photo
[rp1,rp2,rp3,rp4,rp5] = rescaleImage(photo1, p1, p2,p3,p4,p5);

%% For each frame, get 5 points (i.e. p1 to p2), calculate H
% Note:
% rp1 to rp5 are set at the start of the game
% p1 to p5 will be the tracked points, and are changing each frame
% Suppose: x is a point on player photo and x_prime is a point on the game window
%          x_prime = H*x
% 
% maybe we could use this inv(H) to determine if a point is inside the
% player photo (aka the paddle)
H = projectPhoto(I, photo1, p1, p2,p3,p4,p5,rp1,rp2,rp3,rp4,rp5);

%% show the frame
B = projectPoint(H, photo1, I); % project each pixel on photo1 onto image I
imshow(B);
