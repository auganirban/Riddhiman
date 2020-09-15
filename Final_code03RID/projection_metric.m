function [ d ] = projection_metric( t1,t2 )
%SVD Based Projection metric on SE(3)
%   t1 and t2 are elements of SE(3) and a1,a2 are elements of SO(4)   
%     t1= DQuaternionToMatrix(dq1);
%     t2= DQuaternionToMatrix(dq2);
    [U1,S1,V1] = svd(t1);
    [U2,S2,V2] = svd(t2);
    a1 = U1*V1';
    a2 = U2*V2';
    x = a2*a1';
    I = eye(4);
    mat = (I-x);
    d = norm(mat,'fro');

end

