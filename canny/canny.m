clc; clear; close all;
%% environment variables

% img_file = './images/circleBlured.png';
% img_file = './images/Fig0107(a)(chest-xray-vandy).tif';
img_file = './images/Fig0107(c)(headCT-Vandy).tif';
% img_file = './images/mecca06.jpg';
% img_file = './images/shapessm.jpg';

sigma = 1;
th = 50;
tl = 10;

img = imread(img_file);
if(size(img,3) == 3)
    img = rgb2gray(img);
end

%% Step 1: Generation of Masks
[mfx, mfy] = createFilter(sigma);

mfx = round(mfx*255);
mfy = round(mfy*255);

%% Step 2: Applying Masks to Images
edges_x = conv2(double(img), mfx);
edges_y = conv2(double(img), mfy);

figure; colormap gray;
subplot(2,4,1); imagesc(img); title('Original image')
set(gca,'XTick',[], 'YTick',[]);
subplot(2,4,2); imagesc(edges_x); title('Gradient X');
set(gca,'XTick',[], 'YTick',[]);
subplot(2,4,3); imagesc(edges_y); title('Gradient Y');
set(gca,'XTick',[], 'YTick',[]);

M = sqrt((edges_x.^2 + edges_y.^2));
M = M ./ max(M(:))*255; % Gradient Magnitude normalized b/w 0-255
subplot(2,4,4); imagesc(M); title('Gradient Magnitude normalized b/w 0-255');
set(gca,'XTick',[], 'YTick',[])

gradient  = atan2d( edges_y, edges_x) + 180;
% figure; imagesc(gradient); colormap gray;

% idx = M < 10;
% gradient(idx) = -1;
% figure; imagesc(gradient); colormap jet;

%% Step 3: Non Maxima Suppression
q_img = zeros(size(gradient));

% [0 to 22.5] [157.5 to 202.5] [337.5 to 360] - horizontal direction
a = gradient < 22.5;
b = gradient > 157.5 & gradient < 202.5;
c = gradient > 337.5 & gradient <= 360;
q_img(a) = 1;
q_img(b) = 1;
q_img(c) = 1;

a = conv2(M, [0 1 -1]', 'same');
b = conv2(M, [-1 1 0]', 'same');
c = (a > 0) & (b > 0);
md1 = (q_img == 1) & c;

% 22.5 to 67.5 - 202.5 to 247.5
a = gradient > 22.5 & gradient < 67.5;
b = gradient > 202.5 & gradient < 247.5;
q_img(a) = 2;
q_img(b) = 2;

a = conv2(M, [-1 0 0; 0 1 0; 0 0 0], 'same');
b = conv2(M, [0 0 0; 0 1 0; 0 0 -1], 'same');
c = (a > 0) & (b > 0);
md2 = (q_img == 2) & c;

% 67.5 to 112.5 - 247.5 to 292.5
a = gradient > 67.5 & gradient < 112.5;
b = gradient > 247.5 & gradient < 292.5;
q_img(a) = 3;
q_img(b) = 3;

a = conv2(M, [0 1 -1], 'same');
b = conv2(M, [-1 1 0], 'same');
c = (a > 0) & (b > 0);
md3 = (q_img == 3) & c;

% 112.5 to 157.5 - 292.5 to 337.5
a = gradient > 112.5 & gradient < 157.5;
b = gradient > 292.5 & gradient < 337.5;

q_img(a) = 4;
q_img(b) = 4;

a = conv2(M, [0 0 -1; 0 1 0; 0 0 0], 'same');
b = conv2(M, [0 0 0; 0 1 0; -1 0 0], 'same');
c = (a > 0) & (b > 0);
md4 = (q_img == 4) & c;

epxl = md1 | md2 | md3 | md4;
M2 = zeros(size(M));
M2(epxl) = M(epxl);

idx = M < 10;
q_img(idx) = -1;

ax1 = subplot(2,4,5); 
imagesc(q_img); colormap(ax1,jet); title('Quantized gradients');
set(gca,'XTick',[], 'YTick',[]);
subplot(2,4,6); imagesc(M2); title('Gradient suppressed');
set(gca,'XTick',[], 'YTick',[]);
 
%% Step 4: Hysteresis Thresholding
% constraint treversal
a = (epxl > 0) & (M2 < tl);
b = (epxl > 0) & (M2 >= th);
visited = epxl;
visited(a) = 0;
visited(b) = 1;
 
% make border pixels zero
M2(1:1, :) = 0;
M2(:,1:1) = 0;
M2(end:end,:) = 0;
M2(:,end:end) = 0;
 
edges = zeros(size(M2));
recursion_count = 0;
direction = 0;
for i = 2:size(M2,1)-2
    for j = 2:size(M2,2)-2
        if(visited(i,j))
            edges(i,j) = 1;
            pt = [i, j];
            [M2, visited, edges, ~, ~] = hysteresis(M2, visited, edges, ...
                recursion_count, pt, tl, direction);
            recursion_count = 0;
            direction = 0;
        end         
    end
end
 
subplot(2,4,7); imagesc(edges); title('Detected edges');
set(gca,'XTick',[], 'YTick',[])