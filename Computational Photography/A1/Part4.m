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

%Histogram Gray
binsGray=zeros(1,256);
flatXgray = reshape(gray,1,numel(gray));
for val = 0:255
    binsGray(val+1) = sum(flatXgray==val);
end
binsGray = binsGray/sum(binsGray);
subplot(2,1,1);
legend(bar(binsGray),'Gray');

for k=30:130
    C(k) = uint8(sum(H(1:k))*255);
end

newIm = C(double(gray)+1);

%Histogram Strected Picture
binsNewIm=zeros(1,256);
flatXnewIm = reshape(newIm,1,numel(newIm));
for val = 0:255
    binsNewIm(val+1) = sum(flatXnewIm==val);
end
binsNewIm = binsNewIm/sum(binsNewIm);
subplot(2,1,2);
legend(bar(binsNewIm),'Strected');

figure;imshow(newIm);
figure;imshow(gray);
