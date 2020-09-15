function [ m,e] = convergence_test(q1,q2)
% Distance metric for rotation.
    q1r = q1(:,1:4);
    q2r = q2(:,1:4);
    s = q1-q2;
    a = q1+q2;
    n1 = sqrt(s(1,1)^2+s(1,2)^2+s(1,3)^2+s(1,4)^2);
    n2 = sqrt(a(1,1)^2+a(1,2)^2+a(1,3)^2+a(1,4)^2);
    N = [n1 n2];
    m = min(N)
    
% Error in position between two poses
    p1 = DQuaternionToMatrix(q1);
    p2 = DQuaternionToMatrix(q2);
    e =  sqrt ((p2(1,4)-p1(1,4))^2 + (p2(2,4)-p1(2,4))^2  + (p2(3,4)-p1(3,4))^2)
    
end