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

%Result
imshow(gray);

%Test
%test = rgb2gray(im);
%imshow(test);

