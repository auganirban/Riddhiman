function [ rot_met ] = met_rot( r1 , r2 )
%Metric for rotations
%   Function which takes in two rotation matrices as input and computes the
%   distance between the two
    rot_met = norm(logm(r1*r2'));

end

