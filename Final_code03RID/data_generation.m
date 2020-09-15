%% Script for generating data in the x-y plane 
clear
close all;
load('Demo.mat','Demostrat1');
[theta1, g_st1, DualQuaternion1] = denoising(Demostrat1);

T_demo = g_st1(:,:,end); % Final ee configuration for demo

R_demo = T_demo(1:3,1:3);%Rotation matrix of the Final Configuration
delta_x = 0.025;
delta_y = 0.025;
delta_z_angle = pi/20; % Assuming that we will be only rotating about z-axis of demo configuration
nn_x = 5; % 2*nn_x+1 is the number of discrete x-values used
nn_y = 5; % 2*nn_y+1 is the number of discrete y-values used 
nn_rot = 7; % 2*nn_rot+1 is the number of discrete orientations used
x_demo = T_demo(1,4); y_demo = T_demo(2,4); z_demo = T_demo(3,4)+0.03;
% Range of x-coordinates for the "thought experiments"
x_min = x_demo - nn_x*delta_x; 
x_max = x_demo + nn_x*delta_x;

% Range of y-coordinates for the "thought experiments"
y_min = y_demo - nn_y*delta_y;
y_max = y_demo + nn_y*delta_y;

% Range of angular deviation about z-axis of final orientation in demo
del_rot_min = 0 - nn_rot*delta_z_angle;
del_rot_max = 0 + nn_rot*delta_z_angle;
% Total number of scenarios considered
count_scenario = (2*nn_x + 1)*(2*nn_y+1)*(2*nn_rot+1);
count=1;
for x = x_min:delta_x:x_max
    for y = y_min:delta_y:y_max
        for del_rot=del_rot_min:delta_z_angle:del_rot_max
            P = [x y z_demo]';
            delR = [cos(del_rot) -sin(del_rot) 0; ...
                sin(del_rot) cos(del_rot) 0; ...
                0 0 1]; % deviation of current orientation from demo orientation
            Temp(:,:,count) = [R_demo*delR P ; zeros(1,3) 1] ;
            count = count+1;
        end
    end
end

% fileID1 = fopen('SVM_Train_Successful.txt', 'w'); %NC - changed to 'w' from 'a'
% fileID2 = fopen('SVM_Train_Not_Converging.txt', 'w');
% fileID3 = fopen('SVM_Train_Unsuccessful.txt', 'w');
conv_status = true;
count_success = 0;
count_failure = 0;
count_store1 = 1;
count_store2 = 1;
count_store3 = 1;
for i = 1:count_scenario
    [conv_status,counter,setofposes] = chap3_svm( Temp(:,:,i),theta1, g_st1, DualQuaternion1 );
    %Rotation matrix of generated point
    R_temp = Temp(1:3,1:3,i);
    if (conv_status == true) && (counter == 0)
%        [dq] = MatrixToDQuaternion( Temp(:,:,i) );
%         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
%         %have to change
                
%         fprintf(fileID1,'%f,%f\n', mindist,rot_met);
        Successful_Points(:,:,count_store1) = Temp(:,:,i);
        count_success = count_success + 1;
        count_store1 = count_store1 + 1;
        
    elseif (conv_status == false) && (counter == 0)
%        [dq] = MatrixToDQuaternion( Temp(:,:,i) );
%         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
        
%         fprintf(fileID2,'%f,%f\n', mindist,rot_met);
        NonConverging_Points(:,:,count_store2) = Temp(:,:,i); 
        count_failure = count_failure + 1;
        count_store2 = count_store2 + 1;
      
    elseif (conv_status == true) && (counter > 0)
%        [dq] = MatrixToDQuaternion( Temp(:,:,i) );
%         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
        
%         fprintf(fileID3,'%f,%f\n', mindist,rot_met);
        Unsuccessful_Points(:,:,count_store3) = Temp(:,:,i);
        count_failure = count_failure + 1;
        count_store3 = count_store3 + 1;
    end
    
end
% fclose(fileID1);
% fclose(fileID2);
% fclose(fileID3);
% save ('Success','Successful_Points');
% save ('Non_Converging','NonConverging_Points');
% save ('Failure','Unsuccessful_Points');
disp('Number of successful scenarios:');
disp(count_success);
disp('Number of failed scenarios:');
disp(count_failure);

