%%Script for plotting the generated data
%Load the saved data files
% load('Successful_Points.mat');
% load('NonConverging_Points.mat');
% load('Unsuccessful_Points.mat');

%Naming the plot
figure('Name','Computed Path for the Fluid Transfer task');

%Scaling factor which is used 
scaling_f = 0.04;

%Following code plots the successful points
for i = 1:size(g_final,3)
    %Extracting the translational part
    x = g_final(1,4,i);
    y = g_final(2,4,i);
    z = g_final(3,4,i);
    
    %Extracting the rotational columns
    m_x = g_final(1:3,1,i)';
    m_y = g_final(1:3,2,i)';
    m_z = g_final(1:3,3,i)';

    %Adding the translation and scaled rotation
    v_x = [x,y,z] + scaling_f*m_x;
    v_y = [x,y,z] + scaling_f*m_y;
    v_z = [x,y,z] + scaling_f*m_z;

    %Concatenating to get the points
    p1 = [x,y,z;v_x];
    p2 = [x,y,z;v_y];
    p3 = [x,y,z;v_z];

    %Plotting using 3D line plot
    plot3(p1(:,1),p1(:,2),p1(:,3),'r');
    hold on all; 
    plot3(p2(:,1),p2(:,2),p2(:,3),'g');
    plot3(p3(:,1),p3(:,2),p3(:,3),'b');
    grid on
    
end
% legend('x-axis of demo','y-axis of demo','z-axis of demo');
hold on;
%Following code plots the non-converging points(failure)
for i = 1:size( g_st1,3)
    x =  g_st1(1,4,i);
    y =  g_st1(2,4,i);
    z =  g_st1(3,4,i);

    m_x =  g_st1(1:3,1,i)';
    m_y =  g_st1(1:3,2,i)';
    m_z =  g_st1(1:3,3,i)';


    v_x = [x,y,z] + scaling_f*m_x;
    v_y = [x,y,z] + scaling_f*m_y;
    v_z = [x,y,z] + scaling_f*m_z;


    p1 = [x,y,z;v_x];
    p2 = [x,y,z;v_y];
    p3 = [x,y,z;v_z];



    plot3(p1(:,1),p1(:,2),p1(:,3),'y');
%     hold on all; 
    plot3(p2(:,1),p2(:,2),p2(:,3),'c');
    plot3(p3(:,1),p3(:,2),p3(:,3),'m');
    grid on
end

legend('x-axis of final path','y-axis of final path','z-axis of final path');

figure('Name','Pouring Action for computed path');

%Scaling factor which is used 
scaling_f = 0.04;

%Following code plots the successful points
for i = 100:3:size(g_final,3)
    %Extracting the translational part
    x = g_final(1,4,i);
    y = g_final(2,4,i);
    z = g_final(3,4,i);
    
    %Extracting the rotational columns
    m_x = g_final(1:3,1,i)';
    m_y = g_final(1:3,2,i)';
    m_z = g_final(1:3,3,i)';

    %Adding the translation and scaled rotation
    v_x = [x,y,z] + scaling_f*m_x;
    v_y = [x,y,z] + scaling_f*m_y;
    v_z = [x,y,z] + scaling_f*m_z;

    %Concatenating to get the points
    p1 = [x,y,z;v_x];
    p2 = [x,y,z;v_y];
    p3 = [x,y,z;v_z];

    %Plotting using 3D line plot
    plot3(p1(:,1),p1(:,2),p1(:,3),'r');
    hold on all; 
    plot3(p2(:,1),p2(:,2),p2(:,3),'g');
    plot3(p3(:,1),p3(:,2),p3(:,3),'b');
    grid on
    
end

figure('Name','Pouring Action for demonstrated path');

%Following code plots the pouring action
for i = 100:3:size( g_st1,3)
    x =  g_st1(1,4,i);
    y =  g_st1(2,4,i);
    z =  g_st1(3,4,i);

    m_x =  g_st1(1:3,1,i)';
    m_y =  g_st1(1:3,2,i)';
    m_z =  g_st1(1:3,3,i)';


    v_x = [x,y,z] + scaling_f*m_x;
    v_y = [x,y,z] + scaling_f*m_y;
    v_z = [x,y,z] + scaling_f*m_z;


    p1 = [x,y,z;v_x];
    p2 = [x,y,z;v_y];
    p3 = [x,y,z;v_z];



    plot3(p1(:,1),p1(:,2),p1(:,3),'y');
    hold on all; 
    plot3(p2(:,1),p2(:,2),p2(:,3),'c');
    plot3(p3(:,1),p3(:,2),p3(:,3),'m');
    grid on
end






















%legend('x-axis of demo','y-axis of demo','z-axis of demo','Location','Northwest');
% %Following code plots the unsuccessful points(failure)
% for i = 1:size(Unsuccessful_Points,3)
%     x = Unsuccessful_Points(1,4,i);
%     y = Unsuccessful_Points(2,4,i);
%     z = Unsuccessful_Points(3,4,i);
% 
%     m_x = Unsuccessful_Points(1:3,1,i)';
%     m_y = Unsuccessful_Points(1:3,2,i)';
%     m_z = Unsuccessful_Points(1:3,3,i)';
% 
% 
%     v_x = [x,y,z] + scaling_f*m_x;
%     v_y = [x,y,z] + scaling_f*m_y;
%     v_z = [x,y,z] + scaling_f*m_z;
% 
% 
%     p1 = [x,y,z;v_x];
%     p2 = [x,y,z;v_y];
%     p3 = [x,y,z;v_z];
% 
% 
% 
%     plot3(p1(:,1),p1(:,2),p1(:,3),'y');
%     hold on all; 
%     plot3(p2(:,1),p2(:,2),p2(:,3),'c');
%     plot3(p3(:,1),p3(:,2),p3(:,3),'m');
% end
