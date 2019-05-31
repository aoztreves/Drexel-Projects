%{
Aslan Oztreves
HW2
Computational Photography
Matthew Burlick
%}

%Part1

N =3; %// Define size of Gaussian mask
sigma = 5; %// Define sigma here

ind = -floor(N/2) : floor(N/2);
[X Y] = meshgrid(ind, ind);

gausian = exp(-(X.^2 + Y.^2) / (2*sigma*sigma));
gausian = gausian / sum(gausian(:));
gausian = gausian(:);

im = imread('cameraman.tif');
im = im2double(im);
%{
redChannel = im(:, :, 1);
greenChannel = im(:, :, 2);
blueChannel = im(:, :, 3);
% Blur them
kernel = ones(7)/49;
R = conv2(double(redChannel), kernel, 'same');
G = conv2(double(greenChannel), kernel, 'same');
B = conv2(double(blueChannel), kernel, 'same');
gray = 0.2989 * R + 0.5870 * G + 0.1140 * B
imshow(gray);
%}

im_pad = padarray(im, [floor(N/2) floor(N/2)]);
C = im2col(im_pad, [N N], 'sliding');
C_filter = sum(bsxfun(@times, C, gausian), 1);
out = col2im(C_filter, [N N], size(im_pad), 'sliding');


figure();imshow(im);title('original');
%figure();imshow(out);title("N=3,sigma=5");

%Part2

%[rows, cols] = size(out);
%[x,y] = meshgrid(1:rows,1:cols);

%[gx, gy] = imgradientxy(out);
%overallGradient = gx + gy;

h = -fspecial('sobel');
Gx = imfilter(out,h','replicate');
Gy = imfilter(out,h,'replicate');
grad = Gx + Gy;

%figure();imshow(Gx);title('Gx');
%figure();imshow(Gy);title('Gy');
%figure();imshow(grad);title('Grad');

%Part3

threshold = .2;
BI = grad > threshold;

%figure();imshow(BI);title("Threshold=.3");


%Part4
conn = 4;
t1 = .5;
t2 = .9;


aboveT2 = BI > t2;
[aboveT1r, aboveT1c] = find(BI > t1);
hys = bwselect(aboveT2,aboveT1c,aboveT1r,conn);
%figure();imshow(hys);title("Binary");





