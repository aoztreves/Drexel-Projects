%{
Aslan Oztreves
HW 4
Machine Learning
Matthew Burlick
%}

% clear all variables
clear all;

%Initialize variables
%Reads in the data, ignoring the first row (header) and first column (index).
file = 'spambase.data';
X = csvread(file,1,1);
length = size(X,1);

%Randomizes the data
rng(0);
X = X(randperm(length),:);

%Selects the first 2/3 (round up) of the data for training and the remaining for testing
selected = ceil(length * (2/3));

%Initialize Training and Testing 
training = X(1:selected,:);
testing = X(selected+1:length,:);

%Standardizes the data (except for the last column of course) using the training data

m = mean(training(:,1:end-1));
s = std(training(:,1:end-1));
training = [(training(:,1:end-1)-m)./s,training(:,end)];
testing = [(testing(:,1:end-1)-m)./s,testing(:,end)];

%Divides the training data into two groups: Spam samples, Non-Spam samples
spam=zeros(1,56);
nonSpam=zeros(1,56);
for i=1:size(training,1)
    if(training(i,57) == 1)
        spam = [spam;training(i,1:end-1)];
    else
        nonSpam = [nonSpam;training(i,1:end-1)];
    end
end

%Creates Normal models for each feature for each class.
spam = spam(2:end,:);
nonSpam = nonSpam(2:end,:);
spamPercentage = (size(spam,1)-1)/size(training,1);
nonSpamPercentage = (size(nonSpam,1)-1)/size(training,1);
result = zeros(size(testing,1),1);

%Classify each testing sample using these models and choosing the class label based on which class probability is higher.
%Solved multiplication error
meanSpam = mean(spam);
meanNonSpam = mean(nonSpam);
stdSpam = std(spam);
stdNonSpam = std(nonSpam);
clear i;

for i=1:size(testing,1)
    spamVal = spamPercentage;
    nonSpamVal = nonSpamPercentage;
    %For each testing value find spam/nonspan values
    for j=1:56
        spamVal = spamVal * normpdf(testing(i,j),meanSpam(j),stdSpam(j));
        nonSpamVal = nonSpamVal * normpdf(testing(i,j),meanNonSpam(j),stdNonSpam(j));
    end
    if(spamVal > nonSpamVal)
        result(i) = 1;
    else
        result(i) = 0;
    end
end


%Computes the following statistics using the testing data results:
%(a) Precision (b) Recall (c) F-measure (d) Accuracy

truePositive = 0;
trueNegative = 0;
falsePositive = 0;
falseNegative = 0;

clear i;

final = testing(:,end:end);
%display(result);

for i=1:size(final)
    if(result(i) == final(i))
        if(final(i) == 1)
            truePositive = truePositive + 1;
        else
            trueNegative = trueNegative + 1;
        end
    else
        if(final(i) == 0)
            falsePositive = falsePositive + 1;
        else
            falseNegative = falseNegative + 1;
        end
    end
end

% Compute statistics
precision = truePositive / (truePositive + falsePositive);
recall = truePositive / (truePositive + falseNegative);
fmeasure = 2 * precision * recall / (precision + recall);
accuracy = (truePositive + trueNegative) / (truePositive + trueNegative + falsePositive + falseNegative);

display(precision);
display(recall);
display(fmeasure);
display(accuracy);

%clear all;
