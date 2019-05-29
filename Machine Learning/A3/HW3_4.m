%{
Aslan Oztreves
HW3
Machine Learning
Matthew Burlick
%}

% clear all variables
clear all;

%Initialize variables
file = 'x06Simple.csv';
sfolds = 44;

%20 times does the following:
for i=1:20
    X = csvread(file,1,1);
    lenght = size(X,1);
    %Randomizes the data
    rng(0);
    X = X(randperm(lenght),:);
    
    selected = ceil(lenght/sfolds);
    
    for j=1:sfolds
        start = ((j-1) * selected) + 1;
        endd = start + selected - 1;
        %End clause
        if(endd>lenght)
            endd = lenght;
        end
        if(start>lenght)
            break
        end
        %Initialize Training and Testing 
        training = [X(1:start-1,:); X(endd+1:end,:)];
        testing = X(start:endd,:);
        
        %Standardizes the data (except for the last column of course) using the training data

        m = mean(training(:,1:end-1));
        s = std(training(:,1:end-1));
        training = [(training(:,1:end-1)-m)./s,training(:,end)];
        testing = [(testing(:,1:end-1)-m)./s,testing(:,end)];
        
        %Computes the closed-form solution of linear regression
        %Divide into components
        Xset = training(:,1:2);
        Yset = training(:,3);
        singles = ones(size(training,1),1);
        
        Xset = [singles,Xset];
        singles = ones(size(testing,1),1);
        
        %Train a closed-form linear regression model
        %Calculate theta = (X^T*X)^1*X^T*Y
        transposeX = transpose(Xset);
        theta = inv(transposeX * Xset) * transposeX * Yset;
        %Applies the solution to the testing samples
        final = [singles, testing(:,1:2)] * theta;

        %Computes the mean squared error
        MSE = mean((final - testing(:,3)).^2);
        
        %Computes the root mean squared error
        RMSE = sqrt(MSE);
        
    end
end

%clear all variables
clear all
