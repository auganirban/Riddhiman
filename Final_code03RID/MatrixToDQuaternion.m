% Matrix to Dual Quaternion
function [Q] = MatrixToDQuaternion( M )

m11 = M (1,1);
m21 = M (2,1);
m31 = M (3,1);
m41 = M (4,1);
m12 = M (1,2);
m22 = M (2,2);
m32 = M (3,2);  
m42 = M (4,2);
m13 = M (1,3);
m23 = M (2,3);
m33 = M (3,3);
m43 = M (4,3);
m14 = M (1,4);
m24 = M (2,4);
m34 = M (3,4);
m44 = M (4,4);


w0 = 0.25 *(m11+m22+m33+1);
w1 = 0.25 *(m11-m22-m33+1);
w2 = 0.25 *(-m11+m22-m33+1);
w3 = 0.25 * (-m11-m22+m33+1);

W = [w0 w1 w2 w3];
w11 = max(W);

if w11 == w0
w = sqrt(w11) ;   
x = (m32 -m23)  / (4*w);
y = (m13 - m31) / (4*w);
z = (m21 - m12) / (4*w);

else if w11 == w1
        x = sqrt(w11); 
        w= (m32 -m23)  / (4*x);
        y = (m12 + m21) / (4*x);
        z = (m13 + m31) / (4*x);
else if w11 == w2
        y = sqrt(w11) ;
        w = (m13 -m31)  / (4*y);
        x = (m12 + m21) / (4*y);
        z = (m23 + m32) / (4*y);
else if w11== w3
        z = sqrt(w11) ;
        w = (m21 -m12)  / (4*z);
        x = (m13 + m31) / (4*z);
        y = (m23 + m32) / (4*z);
end
end
end
end

px = m14;
py = m24;
pz = m34;

% Quaternion from rotation matrix is 
%Q_0 =  w + x i + y j + z k;

Q_0= [w x y z];
P = [0 px py pz];


% Dual Quaternion is 
% Q = Q_0 + 0.5*  e * (p i+ p j + p k)* Q_0;


Q_real = Q_0;
Q_dual = 0.5* QMult(P, Q_0);
% %Q_dual_scalar = 0.5 (p_w q_w - dot((P_imag, Q_0_imag)) 
% Q_dual_scalar = 0.5* (- dot(P_imag, Q_0_imag)) %Since the scalar part of P is zero first term vanishes.
% % Q_dual_vector = 0.5 * (p_w*Q_0_imag+ P_imag * Q_0(1,1) + cross(P_imag,Q_0_imag));
% Q_dual_vector = 0.5 * (Q_0(1,1)*P_imag + cross(P_imag,Q_0_imag))

Q = [Q_real,Q_dual];
end