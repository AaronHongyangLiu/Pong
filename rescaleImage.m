function [r_p1, r_p2, r_p3, r_p4, r_p5] = rescaleImage(photo,pt1,pt2,pt3,pt4,pt5)
%RESCALEIMAGE Taking 1 photo and 5 points determine the matching point on
%the image to the points, returns 5 coorisponding point on the
%imageCoordinats in the same order.
Xs = [pt1(1), pt2(1), pt3(1), pt4(1), pt5(1)];
Ys = [pt1(2), pt2(2), pt3(2), pt4(2), pt5(2)];

[height, width] =size(photo);

left = min(Xs);
right = max(Xs);
top = min(Ys);
bottom = max(Ys);

x_distance = right - left;
y_distance = bottom - top;

if x_distance/y_distance - width/height > 0
    % if the points are wider, i.e. y_distance is shorter
    horrizontalLength = x_distance;
    verticalLength = x_distance * height/width;
    mid = (top+bottom)/2;
    
    leftMost = left;
    topMost = round(mid - verticalLength/2);
else
    % if the points are longer, i.e. x_distance is shorter
    verticalLength = y_distance;
    horrizontalLength = y_distance * width / height;
    mid = (left+right)/2;
    
    topMost = top;
    leftMost = round(mid-horrizontalLength/2);
end

r_p1 = normalizePoint(pt1, leftMost, topMost,horrizontalLength, verticalLength , width,height);
r_p2 = normalizePoint(pt2, leftMost, topMost,horrizontalLength, verticalLength , width,height);
r_p3 = normalizePoint(pt3, leftMost, topMost,horrizontalLength, verticalLength , width,height);
r_p4 = normalizePoint(pt4, leftMost, topMost,horrizontalLength, verticalLength , width,height);
r_p5 = normalizePoint(pt5, leftMost, topMost,horrizontalLength, verticalLength , width,height);
end


