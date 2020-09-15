function[joint_angles] = Joint_angle_check(joint_angles)

%    % joint_limits = [
% %     -2.3    0.7; % s0
% %     -2.0    0.9; % s1
% %     -2.9    2.9; % e0
% %     0       2.5; % e1
% %     -2.9    2.9; % w0
% %     -1.4    1.9; % w1
% %     -2.9    2.9; % w2
% % ];
%%% Updated Joint limits 07/13
%    % joint_limits = [
% %     -1.7016    +1.7016; % s0
% %     -2.147    1.047; % s1
% %     -3.0541    3.0541; % e0
% %     -0.05       2.618; % e1
% %     -3.059    3.059; % w0
% %     -1.57    2.094; % w1
% %     -3.059    3.059% w2
% % ];


if joint_angles(1,1)<-1.6916 
    joint_angles(1,1)= -1.6916;
else if joint_angles(1,1)> 1.6916
        joint_angles(1,1) = 1.6916;
    end
end
if joint_angles(2,1)<-2.137
    joint_angles(2,1)= -2.137;
else if joint_angles(2,1)> 1.137
        joint_angles(2,1) = 1.137;
    end
end
if joint_angles(3,1)<-3.0441
    joint_angles(3,1)= -3.0441;
else if joint_angles(3,1)> 3.0441
        joint_angles(3,1) = 3.0441;
    end
end
if joint_angles(4,1)<0.04
    joint_angles(4,1)= 0.04;
else if joint_angles(4,1)> 2.6080
        joint_angles(4,1) = 2.6080;
    end
end
if joint_angles(5,1)<-3.044
    joint_angles(5,1)= -3.044;
else if joint_angles(5,1)> 3.044;
        joint_angles(5,1) = 3.044;
    end
end
if joint_angles(6,1)<-1.55
    joint_angles(6,1)= -1.55;
else if joint_angles(6,1)> 2.08
        joint_angles(6,1) = 2.08;
    end
end
if joint_angles(7,1)<-3.044
    joint_angles(7,1)= -3.044;
else if joint_angles(7,1)> 3.044
        joint_angles(7,1) = 3.044;
    end
end
end