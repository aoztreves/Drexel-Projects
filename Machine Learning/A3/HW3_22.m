
%{
Aslan Oztreves
HW3
Machine Learning
Matthew Burlick
%}

% clear all variables
clear all;

%Initialize variables

position = 0;
learningRate = 0.3;
difference = 1;
counter = 0;
%We don't know the size so we can't allocate
IvsX = [];
IvsG = [];
%Calculations until limit = 2.^-21

while(difference > 2.^-21)
    temp = position;
    position = position - learningRate*4*((position-1).^3);
    difference = abs(position - temp);
    %"Intelligiently"
    if(learningRate * 4 * ((temp-1).^3) * learningRate * 4 * ((position-1).^3) < 0)
        learningRate = learningRate./2;
    end
    tempIvt = [counter,position];
    tempIvg = [counter,(position-1).^4];
    
    IvsX = [IvsX;tempIvt];
    IvsG = [IvsG;tempIvg];
    
    counter = counter + 1;
end


%plot(IvsG(:,1),IvsG(:,2)); %Iteration vs g(x)
plot(IvsX(:,1),IvsX(:,2)); %Iteration vs x