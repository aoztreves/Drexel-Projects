%{
Aslan Oztreves
HW1
Computational Photography
Matthew Burlick
%}

%Reading Image
im = imread('test.jpg');

%Getting Values RGB
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

%Setting up Gray
gray = (0.2989 * r) + (0.5870 * g) + (0.1140 * b);

%Thresholds
im25p = imbinarize(gray,.25);
im50p = imbinarize(gray,.50);
im75p = imbinarize(gray,.75);

%Results
figure(1);
imshow(im25p);
figure(2);
imshow(im50p);
figure(3);
imshow(im75p);

