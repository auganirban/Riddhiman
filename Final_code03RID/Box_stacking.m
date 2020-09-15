function [joint_angles, angle_prev,g_final] = Box_stacking(initial_pose, Joint_angles, temp21, theta1, DualQuaternion1)
%% Load Data %%NC01
% theta : The set of joint angles for the manipulator for the recorded
% motion in the form [S0;S1;E0;E1;W0;W1;W2]

%%%% Memorized Trajectory is R001

% load('T001.mat','Stacking_Trajectory');
%load('R4.mat','theta');
%newobj =load('R11.mat','g_st');
%temp21 = newobj.g_st(:,:,100);

%% If no denoising then uncomment
%   g_st1 = g_st;
%  theta1 =theta;
%  DualQuaternion1 = DualQuaternion;
%% Denoising using dual quaternion

%[g_st1, theta1,DualQuaternion1] = Denoise( DualQuaternion,theta,g_st);
%% Denoising in joint space



%% Grid
grid_theta = 1;
grid_y = 1;
grid_x = 1;
%Table01(6,6,11) = 0;
%Table01 = zeros(mm,nn,uu);
Table01 = zeros(11,11,9);
%% New Object configuration

                 %Stacking Configuration 
%                 temp21 = [-0.6511   -0.0518    0.7572  0.97571;
%                           -0.1643    0.9836   -0.0740  0.15915;
%                           -0.7410   -0.1726   -0.6489  -0.01651;
%                                0		0	      0	   1.0000];
%          initial_pose = forward_kinematics(theta1(:,1)); 
%          initial_pose =[-0.7156   -0.3229    0.6193    0.8831;
%                         -0.1640    0.9395    0.3004    0.5611;
%                         -0.6789    0.1134   -0.7253   -0.0154;
%                              0         0         0    1.0000];
%          counter=1;
%            for j = 1:5
            q = MatrixToDQuaternion(temp21);
            
            %% Section 3: Computes the imitated motion from a new object configuration (q) %NC01
            [ new_pose, g_new] = Transformation1(q,DualQuaternion1'); %NC01
            %% Section 4: Dual Quaternion interpolation %%NC01
            %Parameters:
            % Variable i indexes into the imitated trajectory.
            i = 1; % Pose to start interpolation on imitated motion
            step = 1;
            sam =  25;   % Sample number of the dual quaternion to be taken from the interpolation result
            t = 0.01;   % Interpolation step
            m = 1;      % Error in orientation between current pose and guiding pose on imitated trajectory
            e = 1;      % Error in position between current pose and guiding pose on imitated trajectory
            mf = 1;     % Error in orientation between current pose and final pose.
            ef = 1;     % Error in position between current pose and final pose.
            
            joint_angles(:,1) = theta1(:,1);
            % theta_initial = [ 0.085519; -0.86478;-0.004602; 1.12402; -0.120034; 1.06151;0.368155];
            % joint_angles(:,1) = theta_initial;
%              initial_pose = forward_kinematics(theta1(:,1));
            
            position_tol = 1e-03;   %%%% NC
            orientation_tol = 1e-03; %%%%   NC
            length_trajectory = size(new_pose,1); %%%% NC
            
            q1 = MatrixToDQuaternion(initial_pose);
            q2 = new_pose(i,:);
            %q2 = new_pose(end,:); % This should give us a velocity IK-based solution without using the demonstrated motion
            [m, e] = convergence_test(q1,q2); %%% New Addition
            if(e > position_tol || m > orientation_tol) % Starting point is not the initial point of imitating trajectory
                [G,result] = ScLERP( q1,q2,t);  % ScLERP is the function for Screw Linear Interpolation %NC01
            end
            S(:,1) = [initial_pose(1:3,4,1)' q1(1,1:4)];
            k = 2;
            
          
                
            
            while ef(k-1) > position_tol || mf(k-1) > orientation_tol
                % Compute the desired configuration at any iteration
                if (e(k-1) > position_tol || m(k-1) > orientation_tol)
                    g1(:,:,k) = G(:,:,sam);  % Desired configuration is a point from the interpolation if imitated path is not reached.
                else
                    if (i < length_trajectory)
                        g1(:,:,k) = g_new(:,:,i);  % Desired configuration is on the path if imitated path is reached and all points on
                        i = i+step;% imitated path is not exhausted. Interpolation is not required.
                    else
                        g1(:,:,k) = g_new(:,:,end); % Desired configuration is always the end point once all the points on the imitated path are exhausted.
                    end
                end
                %k
                % Find the new current joint angles and the actual current
                % configuration based on previous actual configuration and current
                % desired configuration
                [S(:,k),joint_angles(:,k),g_final(:,:,k),q1(k,:)] = redundancy_res_with_JLA(g1(:,:,k),S(:,k-1),joint_angles(:,k-1)); %NC01
                
               
                % Compute the distance of current configuration to the next guide
                % configuration on imitated path
                [m(k),e(k)] = convergence_test(q1(k,:),q2);
                % Compute the distance of current configuration to goal configuration
                [mf(k),ef(k)] = convergence_test(q1(k,:),new_pose(end,:));
                
                % Compute interpolated path between current configuration and imitated
                % path when the current configuration is not on imitated path.
                if (e(k) > position_tol || m(k) > orientation_tol) % Assignment of q2 for the next interpolation.
                    if (i < length_trajectory)
                        q2 = new_pose(i,:);  % Guide for interpolation from imitated path if imitated path is not reached and all points on imitated path are not exhausted.
                        %plot3(g_new(1,4,i),g_new(2,4,i),g_new(3,4,i),'Xk');
                        i = i + step;
                    else
                        q2 = new_pose(end,:); % The goal configuration is the guide once all the points on the path are exhausted.
                        sam= 20;
                        %plot3(g_new(1,4,end),g_new(2,4,end),g_new(3,4,end),'Xk');
                    end
                    [G,result] = ScLERP( q1(k,:),q2,t);% Computing Interpolated path from current configuration to a configuration on the imitated path. Interpolation
                    % is done only when the imitated path is not reached.
                end
                if k >2000
                    disp('Not Converging')
        %            Table01(grid_x,grid_y,grid_theta) = true;
                    break;
                end
           
            x=joint_angles(:,k)
            
            if (joint_angles(1,k))<-1.7016
                disp('Lower limit of joint 1 violated');
                break;
            else if (joint_angles(1,k))> 1.7016
                disp('Upper limit of joint 1 violated');
                break;
                end
            end
            if (joint_angles(2,k))<-2.147
                disp('Lower limit of joint 2 violated');
                break;
            else if (joint_angles(2,k))> 1.047
                disp('Upper limit of joint 2 violated');
                break;
                end
            end
            if (joint_angles(3,k))<-3.0541
                disp('Lower limit of joint 3 violated');
                break;
            else if (joint_angles(3,k))> 3.0541
                disp('Upper limit of joint 3 violated');
                break;
                end
            end
            if (joint_angles(4,k))<-0.05
                disp('Lower limit of joint 4 violated');
                break;
            else if (joint_angles(4,k))>2.618
                disp('Upper limit of joint 4 violated');
                break;
                end
            end 
            if (joint_angles(5,k))<-3.059
                disp('Lower limit of joint 5 violated');
                break;
            else if (joint_angles(5,k))> 3.059
                disp('Upper limit of joint 5 violated');
                break;
                end
            end
            if (joint_angles(6,k))<-1.5707
                disp('Lower limit of joint 6 violated');
                break;
            else if (joint_angles(6,k))> 2.094
                disp('Upper limit of joint 6 violated');
                break;
                end
            end
            if (joint_angles(7,k))<-3.059
                disp('Lower limit of joint 7 violated');
             break;
            else if (joint_angles(7,k))> 3.059
                disp('Upper limit of joint 7 violated');
                break;
                end
            end
            k = k+1;
            end
            
             [m(k),e(k)] = convergence_test(q1(k-1,:),new_pose(end,:)); %NC01
             
           
           angle_prev = joint_angles(:,end);
           
          end
         