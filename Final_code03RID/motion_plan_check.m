load('Demonstrat3.mat','Demonstrat3');
[theta1, g_st1, DualQuaternion1] = denoising(Demonstrat3);
% count_1 = 0;
% failure_1 = 0;
% count_2 = 0;
% failure_2 = 0;
% count_3 = 0;
% failure_3 = 0;
j=1;
k=1;
l=1;
for i=1:size(Successful_Points,3)
    [conv_status,counter,new_pose] = chap3_svm( Successful_Points(:,:,i),theta1, g_st1, DualQuaternion1 );
    if (conv_status == true) && (counter == 0)
        New_Successful_Points(:,:,j) = Successful_Points(:,:,i);
        j = j+1;
    elseif (conv_status == false) && (counter == 0)
        New_Nonconverging_Points(:,:,k) = Successful_Points(:,:,i);
         k = k+1;
    elseif (conv_status == true) && (counter > 0)
        New_Unsuccessful_Points(:,:,l) = Successful_Points(:,:,i);
         l = l+1;
    end
    
   
   
end
p = j;
q = k;
r = l;
for i=1:size(NonConverging_Points,3)
    [conv_status,counter,new_pose] = chap3_svm( NonConverging_Points(:,:,i),theta1, g_st1, DualQuaternion1 );
    if (conv_status == true) && (counter == 0)
        New_Successful_Points(:,:,p) = NonConverging_Points(:,:,i);
        p = p+1;
    elseif (conv_status == false) && (counter == 0)
        New_Nonconverging_Points(:,:,q) = NonConverging_Points(:,:,i);
         q = q+1;
    elseif (conv_status == true) && (counter > 0)
        New_Unsuccessful_Points(:,:,r) = NonConverging_Points(:,:,i);
         r = r+1;
    end
    
   
   
end
m = p;
n = q;
o = r;
for i=1:size(Unsuccessful_Points,3)
    [conv_status,counter,new_pose] = chap3_svm( Unsuccessful_Points(:,:,i),theta1, g_st1, DualQuaternion1 );
    if (conv_status == true) && (counter == 0)
        New_Successful_Points(:,:,m) = Unsuccessful_Points(:,:,i);
         m = m+1;
    elseif (conv_status == false) && (counter == 0)
        New_Nonconverging_Points(:,:,n) = Unsuccessful_Points(:,:,i);
        n = n+1;
    elseif (conv_status == true) && (counter > 0)
        New_Unsuccessful_Points(:,:,o) = Unsuccessful_Points(:,:,i);
        o = o+1;
    end
   
    
    
end
