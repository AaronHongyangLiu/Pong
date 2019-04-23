clear all;
load('testingGT.mat')

%% taking player photos, in this test, we are only using photo1
[photo1,photo2] = takingPhoto();
% photo1 = imread("photo1.jpg");
% pause(0.5);
%% get the initial position of the 5 tracked points
I = im2double(rgb2gray(imread('testing0.jpg')));
% these are some test points on the palm of test.jpg
Xs = pts_x{1};
Ys = pts_y{1};
p1 = [Xs(1),Ys(1)];
p2 = [Xs(2),Ys(2)];
p3 = [Xs(3),Ys(3)];
p4 = [Xs(4),Ys(4)];
p5 = [Xs(5),Ys(5)];

%% calculate the corrisponding point on the player photo
[rp1,rp2,rp3,rp4,rp5] = rescaleImage(photo1, p1,p2,p3,p4,p5);

%% For each frame, get 5 points (i.e. p1 to p2), calculate H
% Note:
% rp1 to rp5 are set at the start of the game
% p1 to p5 will be the tracked points, and are changing each frame
%
% Suppose: x is a point on player photo and x_prime is a point on the game window
% then   : x_prime = H*x
% 
% maybe we could use this inv(H) to determine if a point is inside the
% player photo (aka the paddle)
v = VideoWriter('myFile.avi');
v.FrameRate = 2;
open(v);
for i=0:15
    I = im2double(rgb2gray(imread("testing"+i+".jpg")));
    Xs = pts_x{i+1};
    Ys = pts_y{i+1};
    p1 = [Xs(1),Ys(1)];
    p2 = [Xs(2),Ys(2)];
    p3 = [Xs(3),Ys(3)];
    p4 = [Xs(4),Ys(4)];
    p5 = [Xs(5),Ys(5)];
    
    H = projectPhoto(I, photo1, p1, p2,p3,p4,p5,rp1,rp2,rp3,rp4,rp5);
    
    %% show the frame
    B = projectPoint(H, photo1, I); % project each pixel on photo1 onto image I
    
    
    imshow(B);
    writeVideo(v,B);
    pause(0.5);
end

close(v);

