function [r_pt] = normalizePoint(pt, leftMost, topMost,innerWidth, innerHeight, frame_width, frame_height)
%NOMALIZEPOINT Summary of this function goes here
%   Normalize the point from the box made of leftMost, rightMost, topMost,
%   bottmMost into a point in a box with topleft as (0,0) and frame_width
%   and frame_height
    
    r_pt = [0,0];
    
    r_pt(1) = round((pt(1)-leftMost) * frame_width / innerWidth);
    r_pt(2) = round((pt(2)-topMost) * frame_height / innerHeight); 
end

