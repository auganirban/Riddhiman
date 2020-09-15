function [C] = failure_point_index(label,PostProbs)
%Function to sort the array of the indices along with the 
%probabilities
%   label is the vector containing labels of the points and PostProbs is
%   the vector containing the probabilities
for i=1:size(label)
    index(i) = i;
end
A = [index' label PostProbs(:,2)];
C = sortrows(A,[2 3],'descend');
end

