[photo1,photo2] = takingPhoto();
% test coordinates: x = [972,883,954,1082,1006]
%                   y = [365, 436, 548, 433, 471]
I = im2double(rgb2gray(imread('test.jpg')));
p1 = [265,972];
p2 = [436,883];
p3 = [548,954];
p4 = [433,1082];
p5 = [471,1006];

[rp1,rp2,rp3,rp4,rp5] = rescaleImage(photo1, p1, p2,p3,p4,p5);
H = projectPhoto(I, photo1, p1, p2,p3,p4,p5,rp1,rp2,rp3,rp4,rp5);
B = projectPoint(H, photo1, I);
imshow(B);
