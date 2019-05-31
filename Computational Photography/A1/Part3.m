%{
Aslan Oztreves
HW1
Computational Photography
Matthew Burlick
%}

%Reading Image
im = imread('test.jpg');

%Getting Values RGB channels
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

%Setting up Gray
gray = (0.2989 * r) + (0.5870 * g) + (0.1140 * b);

%Histogram Bin Set Up
binsGray=zeros(1,256);
binsRed=zeros(1,256);
binsGreen=zeros(1,256);
binsBlue=zeros(1,256);
flatXgray = reshape(gray,1,numel(gray));
flatXred = reshape(r,1,numel(r));
flatXgreen = reshape(g,1,numel(g));
flatXblue = reshape(b,1,numel(b));
for val = 0:255
    binsGray(val+1) = sum(flatXgray==val);
    binsRed(val+1) = sum(flatXred==val);
    binsGreen(val+1) = sum(flatXgreen==val);
    binsBlue(val+1) = sum(flatXblue==val);
end
binsGray = binsGray/sum(binsGray);
binsRed = binsRed/sum(binsRed);
binsGreen = binsGreen/sum(binsGreen);
binsBlue = binsBlue/sum(binsBlue);

%Results
subplot(4,1,1);
%figure(1);
legend(bar(binsGray),'Gray');
%figure(2);
subplot(4,1,2);
legend(bar(binsRed),'Red');
%figure(3);
subplot(4,1,3);
legend(bar(binsGreen),'Green');
%figure(4);
subplot(4,1,4);
legend(bar(binsBlue),'Blue');
%grid on;



