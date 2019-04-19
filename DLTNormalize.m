function [H] = DLTNormalize(Xs,Ys)
%DLTNORMALIZE Normalize the points, return 3x3 Normalization matrix in
%homogenous form
%   Normalize points so that points are center at 0,0 and distance to
%   origin is sqrt(2)
% Xs: row vector of x coordinate
center_x = mean(Xs);
center_y = mean(Ys);
numPts = size(Xs, 2);
C = [eye(2) [center_x; center_y]; 0 0 1]; % centering matrix
scale_factor = sqrt(2) / (sum(sqrt(Xs.^2 + Ys.^2))/numPts);
S = diag([scale_factor, scale_factor, 1]);

H = S*C;
end

