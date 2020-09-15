function [ output_args ] = plot_all_fig(g_new, joint_angles,g_final,g_st,q,m,e)


% Plot graphs for:
% Joint angle alues and limits
% End Effector configuration
for k = 1:size(g_st,3)
g_plot1(:,k)=(g_st(1:3,4,k));
end
hold on all
plot3(g_plot1(1,:),g_plot1(2,:),g_plot1(3,:),'g');

for k = 1:size(g_new,3)
g_plot(:,k)=(g_new(1:3,4,k));
end
hold on all
plot3(g_plot(1,:),g_plot(2,:),g_plot(3,:),'b');

for k = 2:size(g_final,3)
g_plot11(:,k-1)=(g_final(1:3,4,k));
end
plot3(g_plot11(1,:),g_plot11(2,:),g_plot11(3,:),'r');
%title('Dataset R701 - R702');

legend('Recorded Motion','Imitated Motion','Final Motion'); 
ylabel('X Axis');
xlabel('Y Axis');
zlabel ('Z Axis');

%% Error plot
figure();
title('Orientation Error Plot')
m = m(1,2:end);
plot(m);
legend('Error in orientation');
xlabel('Error in m');
ylabel('Discrete time sample');

figure()
title('Position error Plot')
e = e(1,2:end);
plot(e);
legend('Error in position');
xlabel('Error in m');
ylabel('Discrete time sample');


%%Error calculation for the two poses interpolation result and pose with
%%which interpolation is done.

% g_endpose = DQuaternionToMatrix(q);
% for i = 1:size(g_final,3)
%     error(1:3,i) = g_endpose(1:3,4)-g_final(1:3,4,i);
% end
%     figure();
%     plot(error')
%     legend('X axis error', 'Y axis error', 'Z axis error');
%     xlabel('Discrete time sample');
%     ylabel('Error in m');

%% Joint Angle Plots
% Joint Limit
% S0 -1.7016	+1.7016  || -0.9681  0.0871
% S1   -2.147	+1.047   || -0.7196  0.0721
% E0  -3.0541	+3.0541  || -0.0136  0.2469
% E1  -0.05     +2.618   ||  0.8600  1.5165
% W0  -3.059    +3.059   || -0.2213  0.0728
% W1  -1.5707   +2.094   ||  0.0626  0.9810
% W2  -3.059    +3.059   || -0.3697  0.0312


%%% Updated Joint limits 07/13
%    % joint_limits = [
% %     -1.7016    +1.7016; % s0
% %     -2.147    1.047; % s1
% %     -3.0541    3.0541; % e0
% %     -0.05       2.618; % e1
% %     -3.059    3.059; % w0
% %     -1.57    2.094; % w1
% %     -3.059    3.059% w2


joint_limit_min = [-1.7016;-2.147;-3.0541;0.05;-3.059;-1.57;-3.059];
joint_limit_max = [1.7016;1.04;3.0541;2.618;3.059;2.094;3.059];
rst = size(joint_angles,2);
figure();
title('Shoulder joint angles plot');
hold on all;
plot(joint_angles(1:2,:)');
plot([0,rst],[joint_limit_min(1,1),joint_limit_min(1,1)],'--r');
plot([0,rst],[joint_limit_min(2,1),joint_limit_min(2,1)],'--b');
plot([0,rst],[joint_limit_max(1,1),joint_limit_max(1,1)],'--r');
plot([0,rst],[joint_limit_max(2,1),joint_limit_max(2,1)],'--b');
legend('S0', 'S1')
ylabel('Joint angle in radians')
xlabel('Discrete time sample')


figure()
plot(joint_angles(3,:)','r');
hold on all;
plot(joint_angles(4,:)','b');

hold on all;
title('Elbow joint angles plot');
plot([0,rst],[joint_limit_min(3,1),joint_limit_min(3,1)],'--r');
plot([0,rst],[joint_limit_min(4,1),joint_limit_min(4,1)],'--b');
plot([0,rst],[joint_limit_max(3,1),joint_limit_max(3,1)],'--r');
plot([0,rst],[joint_limit_max(4,1),joint_limit_max(4,1)],'--b');
legend('E1', 'E0');
ylabel('Joint angle in radians');
xlabel('Discrete time sample');

figure();
hold on all;
%to be fixed - color of plots
title('Wrist joint angles plot');
plot(joint_angles(5:7,:)');

plot([0,rst],[joint_limit_min(5,1),joint_limit_min(5,1)],'--c');
hold on all;
plot([0,rst],[joint_limit_min(6,1),joint_limit_min(6,1)],'--b');
plot([0,rst],[joint_limit_min(7,1),joint_limit_min(7,1)],'--r');
plot([0,rst],[joint_limit_max(5,1),joint_limit_max(5,1)],'--c');
plot([0,rst],[joint_limit_max(6,1),joint_limit_max(6,1)],'--b');
plot([0,rst],[joint_limit_max(7,1),joint_limit_max(7,1)],'--r');
legend('W0', 'W1', 'W2');
ylabel('Joint angle in radians');
xlabel('Discrete time sample');


%% Orientation and position plot of the end effector for the final motion and recorded motion

% Final motion

figure();
scaling_f =0.035;
step1 = 30; % Step size of plot on the final/recorded motion
count = 2; 
check = 0; % for plotting purposes 
  while count < size(g_final,3)
                    

        x = g_final(1,4,count);
        y = g_final(2,4,count);
        z = g_final(3,4,count);
        v_x = g_final(1:3,1,count)'+[x,y,z];
        v_y = g_final(1:3,2,count)'+[x,y,z];
        v_z = g_final(1:3,3,count)'+[x,y,z];
        
        mx = v_x - [x,y,z];
        my = v_y - [x,y,z];
        mz = v_z - [x,y,z];
        v_x = [x,y,z] + scaling_f*mx;
        v_y = [x,y,z] + scaling_f*my;
        v_z = [x,y,z] + scaling_f*mz;
        
        v = [v_x,v_y,v_z];
        %
        
        p1 = [x,y,z;v_x];
        p2 = [x,y,z;v_y];
        p3 = [x,y,z;v_z];
   
        plot3(p1(:,1),p1(:,2),p1(:,3),'r');
        hold on all;
        plot3(p2(:,1),p2(:,2),p2(:,3),'g');
        plot3(p3(:,1),p3(:,2),p3(:,3),'b');
        %axis([-1 1 -1 1 -1 1]);
        xlabel('X Axis');
        ylabel('Y Axis');
        zlabel('Z Axis');
        
        if count == 2
            P = [x,y,z];
        end
        if count > (0.8 *size(g_final,3)) && check == 0
            P1 = [x,y,z]
            check =1;
        end
        if count > size(g_final,3)-100
            step1 = 3;
        end
        count = count + step1;
  end

txt1 = '\leftarrow Start';
text(P(1,1),P(1,2),P(1,3),txt1); 
txt2 = '\leftarrow End';
text(x,y,z,txt2);
% txt1 = '\rightarrow Final Motion';
% text(P1(1,1),P1(1,2),P1(1,3),txt1);
hold on all;

  % Orientation and position of the end effector for the  recorded motion
   count1 = 1;
   step1 = 30;
   check1 = 0;
   scaling_f =0.035;
   while count1 < size(g_st,3)
        x = g_st(1,4,count1);
        y = g_st(2,4,count1);
        z = g_st(3,4,count1);
        v_x = g_st(1:3,1,count1)'+[x,y,z];
        v_y = g_st(1:3,2,count1)'+[x,y,z];
        v_z = g_st(1:3,3,count1)'+[x,y,z];

        mx = v_x - [x,y,z];
        my = v_y - [x,y,z];
        mz = v_z - [x,y,z];
        v_x = [x,y,z] + scaling_f*mx;
        v_y = [x,y,z] + scaling_f*my;
        v_z = [x,y,z] + scaling_f*mz;
        
        v = [v_x,v_y,v_z];
        %
        if count1 > 0.5*(size(g_st,3)) && check1 == 0
            check1 =1;
            P2 = [x,y,z];
        end
        p1 = [x,y,z;v_x];
        p2 = [x,y,z;v_y];
        p3 = [x,y,z;v_z];
        hold on all;
        plot3(p1(:,1),p1(:,2),p1(:,3),'r');
        plot3(p2(:,1),p2(:,2),p2(:,3),'g');
        plot3(p3(:,1),p3(:,2),p3(:,3),'b');
        axis([-1 1 -1 1 -1 1]) ;
        xlabel('X Axis');
        ylabel('Y Axis');
        zlabel('Z Axis');
        count1 = count1 + step1;
        
      
   end
% txt1 = '\leftarrow Recorded Motion';
% text(P2(1,1),P2(1,2),P2(1,3),txt1);   
hold on all; 
legend ('X axis ', 'Y axis', 'Z axis');
title ('Plot of the end effector orientation for recorded (R) and final motion (F)');


end


