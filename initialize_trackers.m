function [dT, T, H] = initialize_trackers(img, x, y, r)

    % INVERSE COMPOSITIONAL ALGORITHM

    pts = size(x,1);

    % Evaluate the gradient of the template
    [gx, gy] = imgradientxy(img); % dT

    % preallocate for speed
    Tgx = zeros((2*r+1)^2, pts);
    Tgy = zeros((2*r+1)^2, pts);
    dT = zeros((2*r+1)^2, 2, pts);
    T = zeros(2*r+1, 2*r+1, pts);
    H = zeros(2, 2, pts);
    % --------------------

    for k = 1:pts % each of the trackers
        % Evaluate the gradient dT of each template (in array form)
        Tgx(:,k) = reshape(gx(round(y(k)-r):round(y(k)+r), ...
            round(x(k)-r):round(x(k)+r)),[],1);
        Tgy(:,k) = reshape(gy(round(y(k)-r):round(y(k)+r), ...
            round(x(k)-r):round(x(k)+r)),[],1);
        dT(:,:,k) = [Tgx(:,k), Tgy(:,k)]; % deriv of template wrt x,y

        % Template image
        T(:,:,k) = img(round(y(k)-r):round(y(k)+r), round(x(k)-r):round(x(k)+r));

        % Compute Hessian
        H(:,:,k) = dT(:,:,k)'*dT(:,:,k); 
    end
    
end