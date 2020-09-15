function [ new_pose,A ] = Transformation1(q,DualQuaternion)
% new_pose is in the form q_r +E(q_d)
m = size(DualQuaternion,1);
%Calculates the transformation between two consecutive dual quaternions in DualQuaternion and uses this
%transformation to compute the same motion for a new object configuration q
new_pose(m,:) = q;
for i = size(DualQuaternion,1):-1:2
    q_1 = (DualQuaternion(m-1,:));
    q_o = DualQuaternion(end,:);
    star = DQConjugate(q_1);
    u = q; 
    delta = DualQMult(star,q_o);
    delta_conj = DQConjugate(delta);
    %norm(delta_conj(1:4))

    new_pose(m-1,:) = DualQMult(u,delta_conj);
%    temp_v = new_pose(m-1,:);
%    ttt = m-1
%    norm(temp_v(1:4))
%    pause(0.1);
    A(:,:,i) = DQuaternionToMatrix(new_pose(m-1,:)); 
    m= m-1;
end 
n = size(A,3);
A = A(:,:,2:n);

end
