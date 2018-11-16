clear all;
load('SalinasA_gt.mat');
load('SalinasA_corrected.mat');
X = reshape(salinasA_corrected,[7138,204]);
Labels = reshape(salinasA_gt,[7138,1]);
Labels = Labels + 1; %because labels originally start at 0

permut = randperm(1000);
randomin = X(permut(1:100),:); %random test
Labels = Labels';

training = X(permut(101:end),:); %rest of X
trainlabs = Labels(permut(101:end),:);


randomlab = Labels(permut(1:100),1); %test labels

heretheyare = knnsearch(training,randomin, 'K',1);

correct = 0;
for i=1:100
   labelcount = zeros(2,1);
   for k=1:size(heretheyare,2)
       knnindex = heretheyare(i, k);
       labelcount( trainlabs(knnindex) ) = labelcount( trainlabs(knnindex) ) + 1;
   end  
   %index here is the highest occuring label #
   [m,index] = max(labelcount);
   if (index == randomlab(i) ) %compare knn classifier to actual label
       correct = correct + 1;

   end
end




