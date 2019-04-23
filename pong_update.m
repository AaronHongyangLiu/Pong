function [ball, speed, x, y] = pong_update(ball, speed, r, x, y, p, im_dim)

    % Updates positions of paddles by p, moves the ball according to its
    % speed, and accounts for collisions
    
    % Initial update of ball and paddle
    ball = ball + speed;
    x = x + p(:,1);
    y = y + p(:,2);
    
    % Ball hits end wall (GOAL)
    if ball(1) < r
        ball = flip(im_dim'/2);
        speed = (rand(2,1)-0.5)*16;
    elseif ball(1) > im_dim(2) - r
        ball = flip(im_dim'/2);
        speed = (rand(2,1)-0.5)*16;
        
    % Ball hits border wall wall
    elseif ball(2) < 0
        ball(2) = -ball(2);
        speed(2) = -speed(2);
    elseif ball(2) > im_dim(1)
        ball(2) = 2*im_dim(1) - ball(2);
        speed(2) = -speed(2);
    end
    
    % Ball hits left paddle
    if inpolygon(ball(1),ball(2),x(1:5),y(1:5))
        disp("left")
        speed = -speed;
        while 1
            ball = ball + speed;
            if ~inpolygon(ball(1),ball(2),x(6:10),y(6:10))
                break
            end
        end
%         % Check which edge ball crossed
%         for i = 1:5 % first point on edge
%             j = mod(i,5)+1; % second point on edge
%             if (ball(1)-x(i))
%         end
    end
    % Ball hits right paddle
    if inpolygon(ball(1),ball(2),x(6:10),y(6:10))
        disp("right")
        speed = -speed;
        while 1
            ball = ball + speed;
            if ~inpolygon(ball(1),ball(2),x(6:10),y(6:10))
                break
            end
        end
    end
    
end