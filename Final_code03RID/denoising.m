function[theta1,g_st,DualQuaternion1] = denoising(theta)

i=1;
k=1;
%load('T003.mat','imi_traj_2'); 
theta1(:,1)= theta(:,1);
while i < (size(theta,2)-1)
    diff(:,i) = abs(theta(:,i+1)-theta1(:,k));
         if max(diff(:,i)) > 0.01
            theta1(:,k+1) = theta(:,i+1);
            g_st(:,:,k) = forward_kinematics(theta1(:,k+1));
            DualQuaternion1(:,k) = MatrixToDQuaternion(g_st(:,:,k));
            k = k+1;
         end
    i = i+1;
end
g_st_1 = forward_kinematics(theta1(:,1));
g_st = cat(3,g_st_1,g_st);
DQ_1 = MatrixToDQuaternion(g_st_1);
DualQuaternion1 = [DQ_1' DualQuaternion1];

theta1_end = theta(:,end);
theta1 = [theta1 theta1_end];
g_st_end = forward_kinematics(theta1_end);
g_st = cat(3,g_st,g_st_end);
DQ_end = MatrixToDQuaternion(g_st_end);
DualQuaternion1 = [DualQuaternion1 DQ_end'];
end