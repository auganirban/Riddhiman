function [ S,joint_angles,g_final,J_st,q1] = redundancy_res(g1,S_prev,joint_angles_prev)
%Code For Redundancy resolution

    q_i = MatrixToDQuaternion(g1);
    S = [g1(1:3,4)' q_i(1,1:4)]';
    S_dot = S - S_prev;    %[x. y. z. q0. q1. q2. q3.]
   
    %% Changes here
    [g,w_e,p] = forward_kinematics(joint_angles_prev);   
    p_hat = hat(p);
    Rot_param_mat    =      [-S_prev(5,1) -S_prev(6,1) -S_prev(7,1); 
                             S_prev(4,1) S_prev(7,1)  -S_prev(6,1);
                            -S_prev(7,1) S_prev(4,1)   S_prev(5,1);
                             S_prev(6,1) -S_prev(5,1)  S_prev(4,1)]';
                         
    prod =   (p_hat)*(Rot_param_mat);                  
    RotM = [eye(3,3), 2* prod ; zeros(3,3) 2*Rot_param_mat];
    V_s  = RotM* S_dot; % W = [x. y. z. w_x w_y w_z]   Spatial Velocity % NC01
    
    [J_st] = jacobian_baxter1(joint_angles_prev);% To check if we using the right Jacobian
    joint_angles_dot_prev = ((J_st)' * inv(J_st* (J_st)'))* V_s; 
    Js_c=((J_st)' * inv(J_st* (J_st)'));
   
    max_angle_change_allowed = 0.01;
    norm_joint_angles_prev= norm(joint_angles_dot_prev,2);
    unit_vec = joint_angles_dot_prev/norm_joint_angles_prev; % find the unit vector
    [max_joint_angle_change, index1] = max(unit_vec); 
   
    if abs(max_joint_angle_change) > max_angle_change_allowed
        f = max_angle_change_allowed/unit_vec(index1,1);
    else
        f = 1;
    end 
    
    del_joint_angles_dot = f*unit_vec;
    joint_angles = del_joint_angles_dot +joint_angles_prev ;
    %joint_angles = Joint_angle_check(joint_angles);
    [g_final] = forward_kinematics(joint_angles);
       
    q_final  = MatrixToDQuaternion(g_final);
    hold on all;
    %plot3(g_final(1,4),g_final(2,4),g_final(3,4),'Xr');
    
    q1 = q_final; % replace the estimated pose q1 with actual pose.
    S = [g_final(1:3,4)' q_final(1,1:4)];
   
end

