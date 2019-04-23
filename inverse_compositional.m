function p = inverse_compositional(img, T, x, y, r, H, dT)
    
    % INVERSE COMPOSITIONAL ALGORITHM
    
    h_ratio = 0.25;
    do_hom = false;
    
    pts = size(x, 1);
    
    % preallocate for speed
    dp = zeros(2, pts);
    % --------------------
    
    % Initialize warp parameters for each of the trackers
    p = zeros(2,pts); 
    
    o = [x,y];
    
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
        
        if mod(j,10) == 0 && do_hom
            n = o + p';
            HL = projectPhoto(img, img, n(1,:),n(2,:),n(3,:),n(4,:),n(5,:),o(1,:),o(2,:),o(3,:),o(4,:),o(5,:));
            HR = projectPhoto(img, img, n(6,:),n(7,:),n(8,:),n(9,:),n(10,:),o(6,:),o(7,:),o(8,:),o(9,:),o(10,:));
            for i = 1:pts
                if i < pts/2
                    b = HL*[o(i,2);o(i,1);1];
                else
                    b = HR*[o(i,2);o(i,1);1];
                end
                b = b./b(3);
                p(1,i) = (1-h_ratio)*p(1,i) + h_ratio*(b(2) - o(i,1));
                p(2,i) = (1-h_ratio)*p(2,i) + h_ratio*(b(1) - o(i,2));
            end
        end
        
        p = max(p, r-[x,y]'+1); % Ensure tracked regions don't move off top or left of screen
        p = min(p, flip(size(img)')-[x,y]'-r); % bottom or right of screen
        if sum(sum(abs(dp))) < 0.1
            break
        end
    end
    p = p';    
end