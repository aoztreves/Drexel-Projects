%{
Aslan Oztreves
HW5
Computational Photography
Matthew Burlick
%}
clear all;
%Part 1
im = imread('test.jpg');
im = rgb2gray(im);

imEdges = edge(im,'canny');

%figure(1);imshow(im);
%figure(2);imshow(imEdges);

%Part 2
%Test
%[H, theta, rho] = hough (imEdges);

I = imEdges;
[width,height] = size(I);
maxTheta = 1/180;
thetaRange = (-maxTheta:1:maxTheta);
maxRho = floor(sqrt(width^2 + height^2)) - 1;
rho = (-maxRho:1:maxRho);
theta = 0:maxTheta:pi;

[xEdges,yEdges] = find(I);

cosine = (0:width-1)'*cos(theta);
sine = (0:height-1)'*sin(theta);

res((1:length(xEdges)),:) = cosine(xEdges,:) + sine(yEdges,:);

for i = 1:length(theta)
    HS(:,i) = hist(res(:,i),rho);
end

%Part 3
%Test
%P  = houghpeaks(HS,3);

numPeaks = 15;
threshold = ceil(0.3*max(HS(:)));
nhSize = floor(size(HS) / 100.0) * 2 ;
[M,N] = size(HS);
peaks = [];

for j = 1:numPeaks
    H = sort(HS(:),'descend');
    
    peakVal = H(1);
    if peakVal >= threshold
        [h,k] = find(HS==peakVal,1);
        
        %Clustering
        lowX = max([floor(h-nhSize(1)) 1]);
        highX = min([ceil(h+nhSize(1)) M]);
        lowY = max([floor(k-nhSize(2)) 1]);
        highY = min([ceil(k+nhSize(2)) N]);
        HS(lowX:highX,lowY:highY) = 0;

        peaks = [peaks;h,k];
    end
end
x = theta(peaks(:,2));
y = rho(peaks(:,1));

%{
figure(); 
pcolor(theta,rho,HS);
shading flat;
colormap('gray');
axis on, axis normal, hold on;
plot(x,y,'s','color','white');
%}

% I was getting errors so I used built in functions to show that works with my own variables.
 
[H,T,R] = hough(imEdges);
P = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(imEdges,-90:1:90,rho,P,'FillGap',200,'MinLength',200); 

figure();
imshow(im);
hold on;
allPoints = [];

for k = 1:4
    xy = [lines(k).point1; lines(k).point2];
      
    x1 = xy(1,1);
    x2 = xy(2,1);
    y1 = xy(1,2);
    y2 = xy(2,2);
    slope = (y2-y1)/(x2-x1);
    xLeft = 1;
    yLeft = slope * (xLeft - x1) + y1;
    xRight = height;
    yRight = slope * (xRight - x1) + y1;
    
    allPoints = [allPoints; x1 y1; x2 y2];
    
    plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color','red');  
end

%Part 4

line1x = [allPoints(1,1); allPoints(2,1)];
line1y = [allPoints(1,2); allPoints(2,2)];

line2x = [allPoints(3,1); allPoints(4,1)];
line2y = [allPoints(3,2); allPoints(4,2)];

line3x = [allPoints(5,1); allPoints(6,1)];
line3y = [allPoints(5,2); allPoints(6,2)];

line4x = [allPoints(7,1); allPoints(8,1)];
line4y = [allPoints(7,2); allPoints(8,2)];

p1 = polyfit(line1x,line1y,1);
p2 = polyfit(line2x,line2y,1);
p3 = polyfit(line3x,line3y,1);
p4 = polyfit(line4x,line4y,1);

x_intersect12 = fzero(@(x) polyval(p1-p2,x),3);
y_intersect12 = polyval(p1,x_intersect12);

x_intersect14 = fzero(@(x) polyval(p1-p4,x),3);
y_intersect14 = polyval(p1,x_intersect14);

x_intersect32 = fzero(@(x) polyval(p3-p2,x),3);
y_intersect32 = polyval(p3,x_intersect32);

x_intersect34 = fzero(@(x) polyval(p3-p4,x),3);
y_intersect34 = polyval(p3,x_intersect34);

intersections = [x_intersect12 y_intersect12; x_intersect14 y_intersect14; x_intersect32 y_intersect32; x_intersect34 y_intersect34];

%Part 5

intersections = round(intersections);
blankimage = ones(850,1100);


homography = intersections(1:4,1:2);
A = transpose(homography);
upperLeftCornerX = find(blankimage(1,:), 1, 'first');
upperRightCornerX = find(blankimage(1,:), 1, 'last');
lowerLeftCornerX = find(blankimage(end,:), 1, 'first');
lowerRightCornerX = find(blankimage(end,:), 1, 'last');
movingPoints = [lowerLeftCornerX lowerRightCornerX upperLeftCornerX upperRightCornerX; lowerLeftCornerX upperLeftCornerX lowerRightCornerX upperRightCornerX];

T = fitgeotrans(A',movingPoints','projective');

imOut = imwarp(im,T);

figure();
imshow(imOut);
figure();
imshow(im);



