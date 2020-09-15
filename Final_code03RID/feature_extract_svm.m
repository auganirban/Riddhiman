load('Demo.mat','Demostrat1');
[theta1, g_st1, DualQuaternion1] = denoising(Demostrat1);

fileID1 = fopen('SVM_Train_Successful.txt', 'w'); %NC - changed to 'w' from 'a'
fileID2 = fopen('SVM_Train_Not_Converging.txt', 'w');
fileID3 = fopen('SVM_Train_Unsuccessful.txt', 'w');
for i = 1:size(Successful_Points,3)
    %Rotation matrix of generated point
    R_temp = Successful_Points(1:3,1:3,i);
    
    [dq] = MatrixToDQuaternion( Successful_Points(:,:,i) );
    [ mindist,pos_met,rot_met ] = distance_feature( dq,DualQuaternion1 );
%     [ rot_dist, trans_dist ] = feature_finaldemo( dq,DualQuaternion1 );
    fprintf(fileID1,'%f,%f\n', pos_met ,rot_met);
end
for i = 1:size(Unsuccessful_Points,3)
%     Rotation matrix of generated point
    R_temp = Unsuccessful_Points(1:3,1:3,i);
    
    [dq] = MatrixToDQuaternion( Unsuccessful_Points(:,:,i) );
    [ mindist,pos_met,rot_met ] = distance_feature( dq,DualQuaternion1 );
%     [ rot_dist, trans_dist ] = feature_finaldemo( dq,DualQuaternion1 );
    fprintf(fileID3,'%f,%f\n', pos_met,rot_met);
end
for i = 1:size(NonConverging_Points,3)
    %Rotation matrix of generated point
    R_temp = NonConverging_Points(1:3,1:3,i);
    
    [dq] = MatrixToDQuaternion( NonConverging_Points(:,:,i) );
    [ mindist,pos_met,rot_met ] = distance_feature( dq,DualQuaternion1 );
%     [ rot_dist, trans_dist ] = feature_finaldemo( dq,DualQuaternion1 );
    fprintf(fileID2,'%f,%f\n', pos_met,rot_met);
end
fclose(fileID1); 
fclose(fileID2);
fclose(fileID3);