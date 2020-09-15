function [ score ] = scoring_function( traj_features, weight_vector  )
%% Function to compute score for a particular trajectory
%   The function takes in the characteristic feature vector for a
%   trajectory and the associated weight vector and computes the scalar score 
size_1 = size(traj_features,1);
size_2 = size(weight_vector,1);
if size_1 == size_2
    score = dot(traj_features,weight_vector);
end
end

