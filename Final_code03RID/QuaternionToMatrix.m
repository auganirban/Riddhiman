function [R] = QuaternionToMatrix(Qm)
for i =1 : size(Qm,1)
    
q1 = Qm(i,1);
q2 = Qm(i,2);
q3 = Qm(i,3);
q0 = Qm(i,4);

M (1,1) = q0*q0 + q1*q1 - q2*q2 - q3*q3;
M (1,2) = (2*q1*q2 - 2*q0*q3);
M (1,3) = 2*q1*q3 + 2*q0*q2;
M (2,1) = (2*q1*q2 + 2*q0*q3);
M (2,2) = q0*q0 + q2*q2 - q1*q1 - q3*q3;
M (2,3) = 2*q2*q3 - 2*q0*q1;
M (3,1) = 2*q1*q3 - 2*q0*q2;
M (3,2)=  2*q2*q3 + 2*q0*q1;
M (3,3)= q0*q0 + q3*q3 - q1*q1 - q2*q2;
R(:,:,i) = M;
end
end