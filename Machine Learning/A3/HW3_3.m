%{
Aslan Oztreves
HW3
Machine Learning
Matthew Burlick
%}

% clear all variables
clear all;

%Initialize variables
%Reads in the data, ignoring the first row (header) and first column (index).
file = 'x06Simple.csv';
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

%Computes the closed-form solution of linear regression
%Divide into components
Xset = training(:,1:2);
Yset = training(:,3);
singles = ones(selected,1);
Xset = [singles,Xset];
singles = ones(size(testing,1),1);

%Calculate theta = (X^T*X)^1*X^T*Y
transposeX = transpose(Xset);
theta = inv(transposeX * Xset) * transposeX * Yset;

%Applies the solution to the testing samples
final = [singles, testing(:,1:2)] * theta;

%Computes the mean squared error
MSE = mean((final - testing(:,3)).^2);
display(MSE);
%Computes the root mean squared error
RMSE = sqrt(MSE);

display(RMSE);

%clear all variables
clear all;
