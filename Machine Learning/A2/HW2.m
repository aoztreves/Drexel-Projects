%{
Aslan Oztreves
HW2
Machine Learning
Matthew Burlick
%}

% clear all variables
clear all;

filename = 'diabetes.csv';
data = csvread(filename);

%display(data);

X3 = data(:,1);
X = data(:,2:9);
counter = 1;

%Standardizes the data
for j = 1:8
    m = mean(X(:,j));
    s = std(X(:,j));
    X(:,counter) = (X(:,counter) - m ) ./s;
    counter = counter + 1;
end

X2 = X(1:end,6:7);

clear j, counter;

%Set k value
k = 2;

myKMeans(X2,k);

function f = myKMeans(X2,k)
    %Seed random number generator with zero
    rng(0);
    %Select k observations and initialize reference vectors
    for i = 1:k
        
        %Generate Random Number
        row = int32 ( randi ([1, size(X2,1)], 1, 1) ) ; 
        
        %Extract row from Xinput
        v_next = X2(row, 1:end); 
        if i == 1
            v = v_next;
        else
            v = [v; v_next];
        end
        
    end
    %Initialize another vector to store previous state
    v_prev = zeros(size(v));
    
    %Loop Initialization
    X3 = [size(X2,1)];
    loop = true;
    total = 0;
    counter = 1;
    writerObj = VideoWriter('aslan.avi');
    writerObj.FrameRate = 1;
    open(writerObj);
    
    while(loop)
        v_prev = v;
        
        clear i;
        %Calculating L2 distance and assigning cluster#
        for i = 1:size(X2,1)
            L2distance = Inf;
            temp = Inf;
            %Calculation
            for j = 1:size(v,1)
                temp = sqrt(sum((X2(i, :) - v(j, :)).^2));
                %Cluster#
                if(temp<L2distance)
                    X3(i,1) = j;
                    L2distance = temp;
                end
            end
            
        end
        clear i,j;
        
        %Computing the new mean values for the vector
        for i = 1:size(v,1)
            z = find(X3(:,1) == i);
            Z = X2(z,:);
            v(i,:) = mean(Z,1);
        end
  
        
        clear i;
        
        %Terminate the process with Manhattan Calculation
        %Store in an array because we have to sum all the values until its less than 2^-23
        
        s = [];
        for i = 1:size(v,1)
            %Calculation
            L1manhattan = sum( abs( v(i,:) - v_prev(i, :)));
            %{
            total = total + L1manhattan;
            if(total < 2^-23)
                loop = false;
                break;
            end
            %}
            if(i == 1)
                s = L1manhattan;
            else
                s = [s L1manhattan];
            end
        end
        %Plotting
        if(loop)
            v1 = v(1,:);
            v2 = v(2,:);
            figure(counter);
            scatter(X2(X3==1,2), X2(X3==1, 1),'xr');
            hold on;
            scatter(X2(X3==2,2), X2(X3==2, 1),'xb');
            hold on;
            scatter(v1(1,2),v1(1,1),'or');
            hold on;
            scatter(v2(1,2),v1(1,1),'ob');
            hold off;
            title('Iteration ' + string(counter));
        end
        if(sum(s(1,:)) < 2^-23)
            loop = false;
        end
        
        writeVideo(writerObj,getframe(gcf));
        counter = counter + 1;
                   
    end
    
    close(writerObj);
    close all;
end
    
    %This didn't work!!
    %***************************
    %{
    prevCluster = zeros(size(cluster));
    clear permutation i;
    loop = true;
    %Calculating Euclidean to measure the distance between observations and
    %reference vectors
    %Initialize distance mat
    while(loop)
        prevCluster = cluster;
        
        L2distance = zeros(length(X), k);
        for i = 1:size(L2distance,1)
            observation = X(i, :);
            for j = 1 : size(L2distance, 2)
                %Calculation
                L2distance(i, j) = sqrt(sum( (cluster(j, :) - observation).^2 ));
            end
        end
        
        %Calculation
        L1 = [];
        for j3 = 1:size(cluster,1)
            L1manhattan = sum( abs(cluster(j3, :) - prevCluster(j3, :)) );

            if(j3 == 1)
                L1 = L1manhattan;
            else
                L1 = [L1 L1manhattan];
            end
        end
        
        if(sum(L1(1, :)) < 2^-23)
            loop = false;
        end
        
        
    %end
    
end
%}




