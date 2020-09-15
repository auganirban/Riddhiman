function [ J_st,S,joint_angles,g_final,q1] = redundancy_res_with_JLA(g1,S_prev,joint_angles_prev)
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
    %Defining the cost function and calculating nu
              Iden=eye(7);
            del_q1=3.4033; 
            qc1=0;
            del_q2=3.194;
            qc2=-0.55;
            del_q3=6.1083;
            qc3=0;
            del_q4=2.67;
            qc4=+1.284;
            del_q5=6.117;
            qc5=0;
            del_q6=3.6647;
            qc6=+0.261;
            del_q7=6.117;
            qc7=0;
            
qc = [qc1;qc2;qc3;qc4;qc5;qc6;qc7];
del_q = [del_q1; del_q2; del_q3; del_q4; del_q5; del_q6; del_q7];
    
    %joint_angles = joint_angles_dot_prev + joint_angles_prev;
   
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
    
    %kc is the constant which can be changed to get different solutions 
    kc = 0;
    nu = kc*(-2*abs(joint_angles - qc)./del_q);
    %Projecting the vector in the nullspace 
             qp=(Iden-(Js_c*J_st))*nu;
             if(norm(J_st*qp,Inf) > 1e-07)
                 error('qp is not in null space');
             end
             
    %Adding the nullspace solution to the main task solution         
    joint_angles = joint_angles + qp ;
    %joint_angles = Joint_angle_check(joint_angles);
    [g_final] = forward_kinematics(joint_angles);
    q_final  = MatrixToDQuaternion(g_final);
    %hold on all;
    %plot3(g_final(1,4),g_final(2,4),g_final(3,4),'Xr');
    %g_final = [orient_init g_final(1:3,4);zeros(1,3) 1];   
    q1 = q_final; % replace the estimated pose q1 with actual pose.
    S = [g_final(1:3,4)' q_final(1,1:4)];
   
end

