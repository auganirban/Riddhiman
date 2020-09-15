function [q] = DualQuaternionAngFormat(Q,t)
% Summary of this function goes here
%   Convert the given dual quaternion (a 1X 8 Matrix into a dual quaternion in  the form
% of cos(theta)and sin(theta))
% The output format of the dual quaternion is Q = Ctheta + S (Stheta)
% where Ctheta = cos (theta_hat/2) Stheta = sin(theta_hat/2) and S = U + EV
% a_0 = (Q(1,1));
% a_1= (Q(1,2));
% a_2 = (Q(1,3));
% a_3 = (Q(1,4));
% b_0 = (Q(1,5));
% b_1= (Q(1,6));
% b_2 = (Q(1,7));
% b_3 = (Q(1,8));
% Q = a + Eb ;
theta = 2*acos (Q(1,1)); % Theta in radians (ALWAYS)

if theta == 0
    n = theta;
else
    n = 0.5* theta;
end
d = - (2* Q(1,5) / sin(n));

for i = 2 :4
U(i) = Q(1,i) / sin(n);
V(i) = (Q(1,i+4) - (0.5*d*U(i)*cos(n)))/sin(n); %%Check what to do.
%Here the first value of the arrays U ad V are dummy values and for
%programming convenience only.
end

%%
% S_hat = [U(2:4) V(2:4)];
% Cos_hat = [cos(t*0.5*theta)  -(0.5 *d*t*sin(t*0.5*theta))]
% sin_hat = [sin(t*0.5* theta) (0.5 *d*t* cos(t*0.5 * theta))]

a_0 = cos(t*n);
a_1 = U(2)*sin(t*n);
a_2 = U(3)*sin(t*n);
a_3 = U(4)*sin(t*n);

b_0 = -(d*t*0.5)*sin(t*n);
b_1 = (V(2)*sin(t*n)) +  ((d*t*0.5)*U(2)*cos(t*n));
b_2 = (V(3)*sin(t*n)) +  ((d*t*0.5)*U(3)*cos(t*n));
b_3 = (V(4)*sin(t*n)) +  ((d*t*0.5)*U(4)*cos(t*n));

q = [a_0 a_1 a_2 a_3 b_0 b_1 b_2 b_3];


end


