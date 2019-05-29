%{
Aslan Oztreves
HW1
Machine Learning
Matthew Burlick
%}

directory = './yalefaces';
filenames = dir(fullfile(directory,'subject*'));

%Matrix (154x1600) created
X = zeros(154,1600);
counter = 1;
for i = 1:numel(filenames)    
    %Reading image name
    name = fullfile(directory,filenames(i).name);
    I1 = imread(name);
    %Resizing it to 40x40
    I2 = imresize(I1,[40 40]);
    %Flatten to 1D
    I3 = I2(:)';
    %Concatenate
    X(counter,:) = I3;
    counter = counter + 1;  
end
clear counter;

%Standardizes the data
counter = 1;
%{

X = X';
for j = 1:1600
    m = mean(X(j,1:154));
    s = std(X(j,1:154));
    X(counter,:) = (X(counter,:) - m ) ./s;
    counter = counter + 1;
end

%}

for j = 1:1600
    m = mean(X(1:154,j));
    s = std(X(1:154,j));
    X(:,counter) = (X(:,counter) - m ) ./s;
    counter = counter + 1;
end

clear counter i j;
%Reduces the data to 2D using PCA

[V,D] = eig(cov(X));
[values,I] = sort(diag(D),'descend');

x = X * V(:, I(1));
y = X * V(:, I(2));

%Graph
scatter(x,y);

%End
clear




