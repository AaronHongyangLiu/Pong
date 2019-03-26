function p = inverse_compositional(img, T, x, y, r, H, dT)
    
    % INVERSE COMPOSITIONAL ALGORITHM
    
    pts = size(x, 1);
    
    % preallocate for speed
    dp = zeros(2, pts);
    % --------------------
    
    % Initialize warp parameters for each of the trackers
    p = zeros(2,pts); 
    
    % Repeat while dp >= 0.05
    for j = 1:100
        % Compute warp error
        for k = 1:pts
            Iwarp = img(round(y(k)-r+p(2,k)):round(y(k)+r+p(2,k)), ...
                               round(x(k)-r+p(1,k)):round(x(k)+r+p(1,k)));
            E = reshape(Iwarp - T(:,:,k), [], 1);
            dp(:,k) = H(:,:,k)\(dT(:,:,k)'*E);
        end
        % Update warp parameters to warp of inverse warp (-dp) of dp
        p = p - dp;
        if sum(sum(abs(dp))) < 0.1
            break
        end
    end

end