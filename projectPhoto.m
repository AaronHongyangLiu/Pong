function [H] = projectPhoto(...
bgPhoto, photoToBTransformed, ...
pTracked1,pTracked2,pTracked3,pTracked4,pTracked5, ...
pCorri1, pCorri2, pCorri3, pCorri4, pCorri5...
)
%PROJECTPHOTO Summary of this function goes here
%   Tracked points are 5 points on bgPhoto
%   pCoori are points on photoToBeTransformed
tXs = [pTracked1(1),pTracked2(1),pTracked3(1),pTracked4(1),pTracked5(1)];
tYs = [pTracked1(2),pTracked2(2),pTracked3(2),pTracked4(2),pTracked5(2)];
cXs = [pCorri1(1),pCorri2(1),pCorri3(1),pCorri4(1),pCorri5(1)];
cYs = [pCorri1(2),pCorri2(2),pCorri3(2),pCorri4(2),pCorri5(2)];

t_pts = [pTracked1, pTracked2,pTracked3,pTracked4,pTracked5];
c_pts = [pCorri1,pCorri2,pCorri3,pCorri4,pCorri5];

T = DLTNormalize(cXs,cYs);
T_prime = DLTNormalize(tXs,tYs);

%% DLT
syms x_p y_p w_p  x y w
X = [x;y;w];
Ai = [[0 0 0], -w_p*X', y_p*X';...
    w_p*X', [0 0 0], -x_p*X';...
    -y_p*X', x_p*X', [0 0 0];];
A = [];
for i=1:5
    x_actual = T * [c_pts(2*i-1 : 2*i) 1]';
    x_p_actual = T_prime * [t_pts(2*i-1 : 2*i) 1]';
    A = [A; double(subs(Ai, {x,y,w,x_p,y_p,w_p}, {x_actual(1),x_actual(2),x_actual(3),x_p_actual(1),x_p_actual(2),x_p_actual(3) }))];
end
[U, D, V] = svd(A);
h_solved = V(:,size(V,2));
H = reshape(h_solved, [3 3])';
H = inv(T_prime)*H*T;
end

