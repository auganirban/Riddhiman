% Script for training and testing the Support Vector Machine
clear
close all;
%% Reading values from txt file generated in data_generation.m
S = dlmread('SVM_Train_Successful.txt');
U1 = dlmread('SVM_Train_Not_Converging.txt');
U2 = dlmread('SVM_Train_Unsuccessful.txt');

%% Concatenating the unsuccessful and non-converging cases and plotting the data
U = [U1 ; U2];
% sz = 70;
% figure('Name','Plot of the features before classification');
% s1 = scatter(S(:,1),S(:,2),sz,'MarkerEdgeColor',[0 1 0],...
%               'MarkerFaceColor',[0 .3 .7],...
%               'LineWidth',1);
% 
% s1.Marker = '+';          
% hold on;
% s2 = scatter(U(:,1),U(:,2),sz,'MarkerEdgeColor',[1 0 0],...
%               'MarkerFaceColor',[0 .3 .7],...
%               'LineWidth',1);
% s2.Marker = 'o';
% legend('Positive Class','Negetive Class');
% title('Positive and Negetive classes for classification');
% xlabel('Euclidean Distance in R^3 between the position of the points');
% ylabel('Geodesic Distance in SO(3) between the orientation part');

%% Preparing the data for training the Support Vector Machine
data = [S' U']';
size1 = size(S,1);
size2 = size(U,1);
theclass = ones((size1+size2),1);
theclass(size1+1:end) = -1;

%% Preparing Cross Validation
c = cvpartition((size1+size2),'KFold',300);

%% Optimizing the SVM Classifier
opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
    'AcquisitionFunctionName','expected-improvement-plus');
svm = fitcsvm(data,theclass,'KernelFunction','rbf',...
    'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)
% svm = fitcsvm(data,theclass,'KernelFunction','rbf',...
%     'Standardize',false,'ClassNames',[1,-1]);
% 15% holdout sample is used for testing
% compactsvm = svm.Trained{1}; % Extracting the trained, compact classifier
% testInds = test(svm.Partition); % Extracting the test indices 
% XTest = data(testInds,:);
% YTest = theclass(testInds,:);
% L = loss(compactsvm, XTest, YTest,'LossFun','hinge'); %hinge loss which should be close to zero for good classifiers

%% Plotting the Support Vectors
% sv = svm.SupportVectors;
% figure
% s1 = scatter(S(:,1),S(:,2),sz,'MarkerEdgeColor',[0 1 0],...
%               'MarkerFaceColor',[0 .3 .7],...
%               'LineWidth',1);
% 
% s1.Marker = '+';          
% hold on;
% s2 = scatter(U(:,1),U(:,2),sz,'MarkerEdgeColor',[1 0 0],...
%               'MarkerFaceColor',[0 .3 .7],...
%               'LineWidth',1);
% s2.Marker = 'o';
% hold on
% 
% scatter(sv(:,1),sv(:,2),'ko','LineWidth',1)
% 
% legend('Positive','Negetive','Support Vector')
% hold off
%% K Fold Loss
lossnew = kfoldLoss(fitcsvm(data,theclass,'CVPartition',c,'KernelFunction','rbf',...
    'BoxConstraint',svm.HyperparameterOptimizationResults.XAtMinObjective.BoxConstraint,...
    'KernelScale',svm.HyperparameterOptimizationResults.XAtMinObjective.KernelScale))

%% Visualize the optimized classifier
% d = 0.02;
% [x1Grid,x2Grid] = meshgrid(min(data(:,1)):d:max(data(:,1)),...
%     min(data(:,2)):d:max(data(:,2)));
% xGrid = [x1Grid(:),x2Grid(:)];
% [~,scores] = predict(svm,xGrid);
% figure;
% 
% h = nan(3,1); % Preallocation
% h(1:2) = gscatter(data(:,1),data(:,2),theclass,'rg','+*');
% hold on
% h(3) = plot(data(svm.IsSupportVector,1),...
%     data(svm.IsSupportVector,2),'ko');
% contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
% legend(h,{'-1','+1','Support Vectors'},'Location','Southeast');
% print('Optimized_Classifier','-dpdf','-bestfit');
% axis equal
% hold off

%% Generate some new data and evaluate accuracy
% newdata = [0.7566 1.2933; 0.8327 0.9691];
% v = predict(svm,newdata);
% figure;
% h(1:2) = gscatter(data(:,1),data(:,2),theclass,'rg','+*');
% hold on
% h(3:4) = gscatter(newdata(:,1),newdata(:,2),v,'mc','**');
% h(5) = plot(data(svm.IsSupportVector,1),...
%     data(svm.IsSupportVector,2),'ko');
% contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
% legend(h(1:5),{'-1 (training)','+1 (training)','-1 (classified)',...
%     '+1 (classified)','Support Vectors'},'Location','Southeast');
% print('Optimized_Classifier_newdata_exp4','-dpdf','-bestfit');
% axis equal
% hold off

%% Compute Posterior Probabilities
% [ScoreSVMModel,ScoreParameters] = fitSVMPosterior(svm);
% [labels, postprob] = predict(ScoreSVMModel,newdata); %for predicting posterior prob of new data points
% [label,scores] = resubPredict(svm);%calculating scores for the data points
% [~,PostProbs] = resubPredict(ScoreSVMModel);
% table(theclass(100:110),label(100:110),scores(100:110,2),PostProbs(100:110,2),'VariableNames',...
%     {'TrueLabel','PredictedLabel','Score','PosteriorProbability'})%display from 100 to 110

%% Posterior Probability Contour


% figure
% [~,posterior] = predict(ScoreSVMModel,xGrid);
% contourf(x1Grid,x2Grid,reshape(posterior(:,2),size(x1Grid,1),size(x1Grid,2)));
% hold on
% h(1:2) = gscatter(data(:,1),data(:,2),theclass,'rg','+*',15);
% title('Posteriors for Classes');
% xlabel('Euclidean Distance in R^3 between the position of the points');
% ylabel('Geodesic Distance in SO(3) between the rotation parts');
% legend off
% axis tight
% hold off
% colorbar('Location','EastOutside',...
%     'Position',[0.8,0.1,0.05,0.4]);

%% Contour plot according to regions
% figure
% contourf(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid,1),size(x1Grid,2)));
% hold on
% h(1:2) = gscatter(data(:,1),data(:,2),theclass,'rg','+*',15);
% title('{\bf Heat Map according to scores}');
% xlabel('Euclidean Distance in R^3 between the position of the points');
% ylabel('Geodesic Distance in SO(3) between the rotation parts');
% % legend(h,{'setosa region','versicolor region','virginica region',...
% %     'observed setosa','observed versicolor','observed virginica'},...
% %     'Location','Northwest');
% colorbar('Location','EastOutside',...
%     'Position',[0.8,0.1,0.05,0.4]);
% axis tight
% hold off