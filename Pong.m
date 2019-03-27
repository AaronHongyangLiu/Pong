%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear cam
close all
clc

delay = 0;
pts_per_hand = 4;
frames = 100;
r = 20; % radius of square template (half of edge length)

% Initialize webcam
cam = webcam(1);

% Get projection images (eg faces)

% Initialize trackers
imga = RGBarray2gray(snapshot(cam));
figure, imshow(imga);
hold on;

[left_x,left_y] = ginput(pts_per_hand);
[right_x,right_y] = ginput(pts_per_hand);
x = [left_x; right_x];
y = [left_y; right_y];

% Draw homography image overtop

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