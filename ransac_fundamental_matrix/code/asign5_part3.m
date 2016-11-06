clear
close all
close all

addpath(genpath('C:/ITU/vlfeat-0.9.20/'))

% pic_a = imread('../data/Mount Rushmore/9193029855_2c85a50e91_o.jpg');
% pic_b = imread('../data/Mount Rushmore/7433804322_06c5620f13_o.jpg');
% pic_a = imresize(pic_a, 0.25, 'bilinear');
% pic_b = imresize(pic_b, 0.37, 'bilinear');

pic_a = imread('../data/Notre Dame/921919841_a30df938f2_o.jpg');
pic_b = imread('../data/Notre Dame/4191453057_c86028ce1f_o.jpg');
pic_a = imresize(pic_a, 0.5, 'bilinear');
pic_b = imresize(pic_b, 0.5, 'bilinear');

% pic_a = imread('../data/Episcopal Gaudi/3743214471_1b5bbfda98_o.jpg');
% pic_b = imread('../data/Episcopal Gaudi/4386465943_8cf9776378_o.jpg');
% pic_a = imresize(pic_a, 0.8, 'bilinear');
% pic_b = imresize(pic_b, 1, 'bilinear');

% Finds matching points in the two images using VLFeat's implementation of
% SIFT (basically project 2). There can still be many spurious matches,
% though.
[Points_2D_pic_a, Points_2D_pic_b] = sift_wrapper( pic_a, pic_b );
fprintf('Found %d possibly matching features\n',size(Points_2D_pic_a,1));
show_correspondence(pic_a, pic_b, Points_2D_pic_a(:,1), Points_2D_pic_a(:,2), Points_2D_pic_b(:,1),Points_2D_pic_b(:,2));

%% Calculate the fundamental matrix using RANSAC
[F_matrix, matched_points_a, matched_points_b] = ransac_fundamental_matrix(Points_2D_pic_a, Points_2D_pic_b);

%% Draw the epipolar lines on the images and corresponding matches
show_correspondence(pic_a, pic_b, matched_points_a(:,1), matched_points_a(:,2), matched_points_b(:,1),matched_points_b(:,2));

draw_epipolar_lines(F_matrix, pic_a, pic_b, matched_points_a, matched_points_b);