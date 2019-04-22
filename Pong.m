%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear cam
close all
clc

delay = 0;
pts_per_hand = 5;
frames = 100;
r = 20; % radius of square template (half of edge length)

% Get projection images (eg faces)
[photoL, photoR] = takingPhoto();

% Initialize webcam
clear cam
cam = webcam(1);

% Initialize trackers
imga = RGBarray2gray(snapshot(cam));
figure, imshow(imga);
hold on;

[left_x,left_y] = ginput(pts_per_hand);
[right_x,right_y] = ginput(pts_per_hand);
x = [left_x; right_x];
y = [left_y; right_y];

lp1 = [left_x(1), left_y(1)];
lp2 = [left_x(2), left_y(2)];
lp3 = [left_x(3), left_y(3)];
lp4 = [left_x(4), left_y(4)];
lp5 = [left_x(5), left_y(5)];
rp1 = [right_x(1), right_y(1)];
rp2 = [right_x(2), right_y(2)];
rp3 = [right_x(3), right_y(3)];
rp4 = [right_x(4), right_y(4)];
rp5 = [right_x(5), right_y(5)];

% Rescale 
[n_lp1,n_lp2,n_lp3,n_lp4,n_lp5] = rescaleImage(photoL, lp1,lp2,lp3,lp4,lp5);
[n_rp1,n_rp2,n_rp3,n_rp4,n_rp5] = rescaleImage(photoR, rp1,rp2,rp3,rp4,rp5);

% Get homography
HL = projectPhoto(imga, photoL, lp1,lp2,lp3,lp4,lp5,n_lp1,n_lp2,n_lp3,n_lp4,n_lp5);
HR = projectPhoto(imga, photoR, rp1,rp2,rp3,rp4,rp5,n_rp1,n_rp2,n_rp3,n_rp4,n_rp5);

% Draw homography image overtop
imga = projectPoint(HL, photoL, imga);
imga = projectPoint(HR, photoR, imga);
imshow(imga)

% Initialize pong game
ball = flip(size(imga)'/2);
speed = [8;8];
ball_rad = 30;
plot(ball(1), ball(2), 'b.', 'MarkerSize', ball_rad)
hold off;

[dT, T, H] = initialize_trackers(imga, x, y, r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iterate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 2:frames
    pause(delay)
    img = RGBarray2gray(snapshot(cam));
    
    % Uptdate trackers
    p = inverse_compositional(img, T, x, y, r, H, dT);
    
    n_lp1 = [x(1)+p(1,1), y(1)+p(1,2)];
    n_lp2 = [x(2)+p(2,1), y(2)+p(2,2)];
    n_lp3 = [x(3)+p(3,1), y(3)+p(3,2)];
    n_lp4 = [x(4)+p(4,1), y(4)+p(4,2)];
    n_lp5 = [x(5)+p(5,1), y(5)+p(5,2)];
    n_rp1 = [x(6)+p(6,1), y(6)+p(6,2)];
    n_rp2 = [x(7)+p(7,1), y(7)+p(7,2)];
    n_rp3 = [x(8)+p(8,1), y(8)+p(8,2)];
    n_rp4 = [x(9)+p(9,1), y(9)+p(9,2)];
    n_rp5 = [x(10)+p(10,1), y(10)+p(10,2)];
    
    % Get homography
    HL = projectPhoto(img, photoL, lp1,lp2,lp3,lp4,lp5,n_lp1,n_lp2,n_lp3,n_lp4,n_lp5);
    HR = projectPhoto(img, photoR, rp1,rp2,rp3,rp4,rp5,n_rp1,n_rp2,n_rp3,n_rp4,n_rp5);

    % Draw homography image overtop
    img = projectPoint(HL, photoL, img);
    img = projectPoint(HR, photoR, img);

    imshow(img);
    hold on;
    
    % pong_update
    [ball, speed, x, y] = pong_update(ball, speed, ball_rad, x, y, p, size(imga));
    
    plot(ball(1), ball(2), 'b.', 'MarkerSize', ball_rad)
    plot(x, y, 'b.', 'MarkerSize',20)
    % Draw homography image overtop
    
    hold off;
end
clear cam;
disp("end")