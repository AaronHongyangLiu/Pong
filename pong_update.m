function [ball, speed, x, y] = pong_update(ball, speed, r, x, y, p, im_dim)

    % Updates positions of paddles by p, moves the ball according to it's
    % speed, and accounts for collisions
    
    % Initial update of ball and paddle
    ball = ball + speed;
    x = x + p(:,1);
    y = y + p(:,2);
    
    % Ball hits border
    if ball(1) < r
        ball = flip(im_dim'/2);
        speed = [1;1];
    elseif ball(1) > im_dim(2) - r
        ball = flip(im_dim'/2);
        speed = [1;1];
    elseif ball(2) < 0
        ball(2) = -ball(2);
        speed(2) = -speed(2);
    elseif ball(2) > im_dim(1)
        ball(2) = 2*im_dim(1) - ball(2);
        speed(2) = -speed(2);
    end
    
    
end