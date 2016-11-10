% This script 
% (1) Loads and resizes images
% (2) Finds interest points in those images
% (3) visualize intermediate results
clc;clear;close all;
%%
image = imread('../data/Mount Rushmore/9021235130_7c2acd9554_o.jpg');
% image = imread('../data/test.jpg');
image = single(image)/255;

scale_factor = 0.5; 
image = imresize(image, scale_factor, 'bilinear');
image_bw = rgb2gray(image);

feature_width = 16;
[x1, y1] = get_interest_points(image_bw, feature_width, true);
size(x1,1)
