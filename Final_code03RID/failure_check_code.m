load('Demonstrat2.mat','Demonstrat2');
[theta1, g_st1, DualQuaternion1] = denoising(Demonstrat2);

j=0;
k=0;
l=0;
m=1;

for i=1:size(Unsuccessful_Points,3)
    [conv_status,counter,new_pose] = chap3_svm( Successful_Points(:,:,i),theta1, g_st1, DualQuaternion1 );
    if (conv_status == true) && (counter == 0)

        j = j+1;
    elseif (conv_status == false) && (counter == 0)
         Points_check(:,:,m) = Unsuccessful_Points(:,:,i);
         k = k+1;
         m = m+1;
    elseif (conv_status == true) && (counter > 0)
        
         l = l+1;
    end
    
   
   
end


for i=1:size(NonConverging_Points,3)
    [conv_status,counter,new_pose] = chap3_svm( Successful_Points(:,:,i),theta1, g_st1, DualQuaternion1 );
    if (conv_status == true) && (counter == 0)
      
        j = j+1;
    elseif (conv_status == false) && (counter == 0)
         Points_check(:,:,m) = NonConverging_Points(:,:,i);
         k = k+1;
         m = m+1;
    elseif (conv_status == true) && (counter > 0)
      
         l = l+1;
    end
    
   
   
end