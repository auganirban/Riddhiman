function [ mindist,pos_met,rot_met ] = distance_feature( dq,setofposes )
%Function to compute the minimum distance of a query point to the set of
%poses in the end effector space(demonstrated trajectory for our case) and
%then find the translational and rotational distance between the points
%   dq is the query point and setofposes is a 2D matrix of dual quaternions
%   representing the imitated motion

    t1= DQuaternionToMatrix(dq);
    %Rotation matrix of new final configuration
    r1_new = t1(1:3,1:3);
    %Position of new final configuration
    p1_new = t1(1:3,4);
    for i=1:1:size(setofposes,2)
        setofposes_dq(:,:,i) = DQuaternionToMatrix(setofposes(:,i)'); 
        d = projection_metric( t1,setofposes_dq(:,:,i) );
        dist(i)= d;
    end
    %Storing the index of the position whose distance is minimum
    [ mindist,index ] = min(dist);
    %Configuration whose distance is minimum from new final configuration
    T_demo = DQuaternionToMatrix(setofposes(:,index)');
    
    %Rotation matrix of above configuration
    R_demo = T_demo(1:3,1:3);
    %Position of above configuration
    p_demo = T_demo(1:3,4);
    %Rotational distance
    [ rot_met ] = met_rot( r1_new , R_demo );
    %Position Distance
    pos_met = norm(p1_new - p_demo);
    
     
end

