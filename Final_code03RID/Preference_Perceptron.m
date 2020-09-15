function [ w ] = Preference_Perceptron(tf1,tf2,tf3,tf4,tf5)
%% Perceptron type algorithm to compute weights of the score function
k = size(tf1,1);
w = zeros(k,1);
go = true;
% if size(joint_angles,1) == size(user_feedback,1)
    while go 
        %sample trajectories
        %select the trajectory with max score
        s1 = scoring_function(tf1,w);
        s2 = scoring_function(tf2,w);
        s3 = scoring_function(tf3,w);
        s4 = scoring_function(tf4,w);
        s5 = scoring_function(tf5,w);
        [mxm,j] = max([s1,s2,s3,s4,s5]);
        if j == 1
            selected_traj = tf1;
        elseif j == 2
            selected_traj = tf2;
        elseif j == 3
            selected_traj = tf3;
        elseif j == 4
            selected_traj = tf4;
        elseif j == 5
            selected_traj = tf5;
        end
        user_feedback = input('Enter user feedback:');
        user_feedback_prev = user_feedback;
        user_feedback_new = input('Enter new feedback:');
        w = w + (user_feedback - selected_traj);
        if (user_feedback_prev == user_feedback_new)
            go = false;
        end
    end
% end
end

