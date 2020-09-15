function Q = Rot_to_Quat(R)
%Function that takes in a rotation matrix as an argument and outputs a unit
%quaternion 
%The input for the rotation matrix is taken
% R(1,1) = input('Enter r11 :');
% R(1,2) = input('Enter r12 :');
% R(1,3) = input('Enter r13 :');
% R(2,1) = input('Enter r21 :');
% R(2,2) = input('Enter r22 :');
% R(2,3) = input('Enter r23 :');
% R(3,1) = input('Enter r31 :');
% R(3,2) = input('Enter r32 :');
% R(3,3) = input('Enter r33 :');
%Computing the values of q0,q1,q2,q3 using formula
Q(1) = sqrt((R(1,1) + R(2,2) + R(3,3) + 1)/4);
Q(2) = sqrt((R(1,1) - R(2,2) - R(3,3) + 1)/4);
Q(3) = sqrt((-R(1,1) + R(2,2) - R(3,3) + 1)/4);
Q(4) = sqrt((-R(1,1) - R(2,2) + R(3,3) + 1)/4);
%Calculating the max from the computed values and following that series of
%computations
if (Q(1)> Q(2)) && (Q(1)> Q(3)) && (Q(1)> Q(4))
    max= Q(1);
    Q(2)=(R(3,2)-R(2,3))/(4*Q(1));
    Q(3)=(R(1,3)-R(3,1))/(4*Q(1));
    Q(4)=(R(2,1)-R(1,2))/(4*Q(1));
end
if (Q(2)> Q(1)) && (Q(2)> Q(3)) && (Q(2)> Q(4))
    max= Q(2);
    Q(1)=(R(3,2)-R(2,3))/(4*Q(2));
    Q(3)=(R(1,2)+R(2,1))/(4*Q(2));
    Q(4)=(R(1,3)+R(3,1))/(4*Q(2));
end
if (Q(3)> Q(1)) && (Q(3)> Q(2)) && (Q(1)> Q(4))
    max= Q(3);
    Q(1)=(R(1,3)-R(3,1))/(4*Q(3));
    Q(2)=(R(1,2)+R(2,1))/(4*Q(3));
    Q(4)=(R(2,3)+R(3,2))/(4*Q(3));
end
if (Q(4)> Q(1)) && (Q(4)> Q(3)) && (Q(1)> Q(2))
    max= Q(4);
    Q(1)=(R(2,1)-R(1,2))/(4*Q(4));
    Q(2)=(R(1,3)+R(3,1))/(4*Q(4));
    Q(3)=(R(2,3)+R(3,2))/(4*Q(4));
end
end

