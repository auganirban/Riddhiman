function [exi,xi,xih] = expon(w, q, theta)
% This funtion calculates the exponential for xi.
wh = hat(w);
v = -cross(w, q);
xi =  [v;w] ;
xih = [wh v;0 0 0 0];
ew = eye(3) + wh*sin(theta) + (wh^2)*(1 - cos(theta));
p = ((eye(3) - ew)*cross(w, v)) + w*w'*v*theta;
exi = [ew p; 0 0 0 1];
end