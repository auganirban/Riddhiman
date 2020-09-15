clear all;
close all;
clc;
count = 1;
% initial_pose =[-0.7156   -0.3229    0.6193    0.8831;
%                -0.1640    0.9395    0.3004    0.5611;
%                -0.6789    0.1134   -0.7253   -0.0154;
%                     0         0         0    1.0000];
   
% initial_pose =[ -0.6137    0.0109    0.7892    0.7336;
%                 -0.0286    0.9988   -0.0362    0.4217;
%                 -0.7888   -0.0449   -0.6127   -0.0722;
%                     0          0         0    1.0000];
 
% initial_pose =[ -0.9947   -0.0999    0.0164    0.7238;
%                 -0.1005    0.9939   -0.0445    0.4106;
%                 -0.0118   -0.0459   -0.9987   -0.0269;
%                      0         0         0    1.0000];
                 

% initial_pose =[  -0.9974    0.0559    0.0433    0.7364;
%                   0.0558    0.9983   -0.0038    0.4980;
%                  -0.0435   -0.0014   -0.9989   -0.0418;
%                       0         0         0    1.0000];

% initial_pose =[ -0.9793    0.0808    0.1846    0.6657;
%                 0.0708    0.9955   -0.0609    0.4735;
%                -0.1888   -0.0467   -0.9807   -0.0433;
%                     0         0         0    1.0000];
% initial_pose =[  -0.9976    0.0645    0.0150    0.6685;
%                   0.0648    0.9976    0.0212    0.5014;
%                  -0.0136    0.0222   -0.9995   -0.0455;
%                       0         0         0    1.0000];
initial_pose =[-0.9977    0.0006    0.0661    0.6929;
   -0.0023    0.9989   -0.0441    0.4965;
   -0.0661   -0.0442   -0.9967   -0.0470;
         0         0         0    1.0000];


% final_pose = [-0.4718   -0.1377    0.8707    0.8657;
%               -0.2702    0.9627    0.0059    0.1621;
%               -0.8391   -0.2325   -0.4915   -0.0719;
%                    0         0         0    1.0000];

% final_pose = [ -0.5967   -0.0907    0.7970    0.7153;
%                -0.1437    0.9894    0.0050    0.2165;
%                -0.7892   -0.1117   -0.6035   -0.0803;
%                     0         0         0    1.0000];

% final_pose = [-0.9947    0.0582    0.0832    0.7651;
%                0.0503    0.9942   -0.0944    0.1379;
%               -0.0882   -0.0897   -0.9919    0.0576;
%                    0         0         0    1.0000];
% final_pose =[  -0.9992   -0.0015    0.0368    0.7537;
%                -0.0027    0.9994   -0.0330    0.2881;
%                -0.0367   -0.0331   -0.9986   -0.0446;
%                     0         0         0    1.0000];
% final_pose =[ -0.9922    0.0391    0.1167    0.6792;
%                0.0240    0.9913   -0.1286    0.2940;
%               -0.1207   -0.1248   -0.9846   -0.0447;
%                    0         0         0    1.0000];
% final_pose =[ -0.9997    0.0025    0.0144    0.6708;
%                0.0024    0.9999   -0.0037    0.3369;
%               -0.0144   -0.0036   -0.9997   -0.0471;
%                    0         0         0    1.0000];
final_pose =[ -0.9991    0.0206    0.0303    0.6816;
    0.0195    0.9990   -0.0380    0.3211;
   -0.0311   -0.0374   -0.9986   -0.0475;
         0         0         0    1.0000];

%load('T001.mat','Stacking_Trajectory');   
%load('T003.mat','imi_traj_2');
 %load('T111.mat','traj_11');
%load('T112.mat','traj_12');
%load('T113.mat','traj_13');
load('T114.mat','traj_14');
[theta1, g_st1, DualQuaternion1] = denoising(traj_14);
for i= 1:5
    if mod(count,2) == 0
        imi_traj_rev = fliplr(traj_14);
        DualQuaternion1_rev = fliplr(DualQuaternion1);
        theta1_rev = fliplr(theta1);
        theta1_rev = cat(2,angle_prev,theta1_rev);
        [joint_angles, angle_prev, g_final] = Box_stacking(initial_pose, imi_traj_rev , final_pose, theta1_rev, DualQuaternion1_rev);
    else
        [joint_angles, angle_prev, g_final] = Box_stacking(initial_pose, traj_14 , final_pose, theta1, DualQuaternion1);
    end
    if mod(count,2) == 0
        initial_pose = initial_pose + [0, 0, 0, 0;0, 0, 0, 0;0, 0, 0, 0.033;0, 0, 0, 0];
    else
        initial_pose = initial_pose + [0, 0, 0, 0.033;0, 0, 0, 0;0, 0, 0, 0;0, 0, 0, 0];
    end
    if count == 1
        trajectory_2_3 = joint_angles ;
    elseif count == 2
        trajectory_3_4 = joint_angles ;
    elseif count == 3
        trajectory_4_5 = joint_angles ;
    elseif count == 4 
        trajectory_5_6 = joint_angles ;
    elseif count == 5
        trajectory_6_7 = joint_angles ;
    end
    temp = final_pose;
    final_pose = initial_pose;
    initial_pose = temp;
    count = count+1;
    theta1 = cat(2,angle_prev,theta1);
end


