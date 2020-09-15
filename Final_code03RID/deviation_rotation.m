%Function to extract features from a trajectory
function [ Q,Q2,dev ]  = deviation_rotation(joint_angles,final_orientation)
%This function calculates the cosine of the object's maximum deviation
%along the vertical axis
for k=1:size(joint_angles,2)
    [g_st(:,:,k),w_e,p] = forward_kinematics(joint_angles(:,k));
    Rot_mat(:,:,k) = g_st(1:3,1:3,k);
    Q(:,k) =  Rot_to_Quat(Rot_mat(:,:,k));

end

Q2 = Rot_to_Quat(final_orientation(1:3,1:3));
for k=1:size(joint_angles,2)
    dev(k) = 2*acos((Q(1,k)*Q2(1))+(Q(2,k)*Q2(2))+(Q(3,k)*Q2(3))+(Q(4,k)*Q2(4)));
end
end
