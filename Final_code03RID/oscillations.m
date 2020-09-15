%Function to extract features from a trajectory
function [ ps1,ps2,ps3,m1,m2,m3 ] = oscillations ( joint_angles)
%Function to capture tremors or oscillations along the trajectory 
for k=1:size(joint_angles,2)
    [g_st(:,:,k),w_e,p] = forward_kinematics(joint_angles(:,k));
end
x = zeros(1,size(joint_angles,2));
y = zeros(1,size(joint_angles,2));
z = zeros(1,size(joint_angles,2));
for k=1:size(joint_angles,2)
    x(k) = g_st(1,4,k);
    y(k) = g_st(2,4,k);
    z(k) = g_st(3,4,k);
end
x = x(1,1:size(joint_angles,2));
y = y(1,1:size(joint_angles,2));
z = z(1,1:size(joint_angles,2));
%[ eul_angles,cos_comp_z ]  = deviation_rotation(joint_angles,final_orientation);
% s1 = spectrogram(x);
% spectrogram(x,'yaxis')
% s2 = spectrogram(y);
% spectrogram(y,'yaxis')
% s3 = spectrogram(z);
% spectrogram(z,'yaxis')
%w = eul_angles(1,:);
%s4 = spectrogram(w);
%spectrogram(eul_angles(1,:),'yaxis');
 [x,ps1] = spectrogram(x);
 [y,ps2] = spectrogram(y);
 [z,ps3] = spectrogram(z);
% [w,ps4] = spectrogram(w)
m1 = mean(ps1);
m2 = mean(ps2);
m3 = mean(ps3);
end

