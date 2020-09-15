
%load('joints.mat');

clc
%rosinit
% rosinit('011502P0023.local')


%clear
% 
enable=rospublisher('/robot/set_super_enable');
enablemsg=rosmessage(enable.MessageType);
enablemsg.Data=1;
send(enable,enablemsg);

%
bnames=cell(7,1);
bnames{1,1}='left_s0';
bnames{2,1}='left_s1';
bnames{3,1}='left_e0';
bnames{4,1}='left_e1';
bnames{5,1}='left_w0';
bnames{6,1}='left_w1';
bnames{7,1}='left_w2';

commpb=rospublisher('/robot/limb/left/joint_command');
commmsg=rosmessage('baxter_core_msgs/JointCommand');
commmsg.Names=bnames;

joint_angles=[0;0;0;0;0;0;0];

% theta, thetadot subscriber
curthetasub=rossubscriber('/robot/joint_states');
curtheta=rosmessage('sensor_msgs/JointState');
%
r=rosrate(30);

commmsg.Mode=1;
%
reset(r);
for i=1:size(joint_angles,2)
    commmsg.Command=joint_angles(:,i);
    send(commpb,commmsg);
    waitfor(r);
end
% [actClient,goalMsg] = rosactionclient('/robot/end_effector/left_gripper/gripper_action');
% goalMsg.Command.Position = 35;
% sendGoalAndWait(actClient,goalMsg,10);
% reset(r);
%{
for k=1:size(joint_angles,2)
    commmsg.Command=joint_angles(:,k);
    send(commpb,commmsg);
    waitfor(r);
end
%}
% goalMsg.Command.Position = 100;
% sendGoalAndWait(actClient,goalMsg,10);
% reset(r);
% for k=1:size(trajectory_3_4,2)
%     commmsg.Command=trajectory_3_4(:,k);
%     send(commpb,commmsg);
%     waitfor(r);
% end
% goalMsg.Command.Position = 40 % fully closed
% sendGoalAndWait(actClient,goalMsg,10);
% reset(r);
% for k=1:size(trajectory_4_5,2)
%     commmsg.Command=trajectory_4_5(:,k);
%     send(commpb,commmsg);
%     waitfor(r);
% end
% goalMsg.Command.Position = 100 % fully closed
% sendGoalAndWait(actClient,goalMsg,10);
% reset(r);
% for k=1:size(trajectory_5_6,2)
%     commmsg.Command=trajectory_5_6(:,k);
%     send(commpb,commmsg);
%     waitfor(r);
% end
% goalMsg.Command.Position = 40 % fully closed
% sendGoalAndWait(actClient,goalMsg,10);
% reset(r);
% for k=1:size(trajectory_6_7,2)
%     commmsg.Command=trajectory_6_7(:,k);
%     send(commpb,commmsg);
%     waitfor(r);
% end
% goalMsg.Command.Position = 100 % fully closed
% sendGoalAndWait(actClient,goalMsg,10);