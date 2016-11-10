% Local Feature Stencil Code
% CS 4495 / 6476: Computer Vision, Georgia Tech
% Written by James Hays

% Returns a set of feature descriptors for a given set of interest points.

% 'image' can be grayscale or color, your choice.
% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
%   The local features should be centered at x and y.
% 'feature_width', in pixels, is the local feature width. You can assume
%   that feature_width will be a multiple of 4 (i.e. every cell of your
%   local SIFT-like feature will have an integer width and height).
% If you want to detect and describe features at multiple scales or
% particular orientations you can add input arguments.

% 'features' is the array of computed features. It should have the
%   following size: [length(x) x feature dimensionality] (e.g. 128 for
%   standard SIFT)

function [features] = get_features(image, x, y, feature_width)

% To start with, you might want to simply use normalized patches as your
% local feature. This is very simple to code and works OK. However, to get
% full credit you will need to implement the more effective SIFT descriptor
% (See Szeliski 4.1.2 or the original publications at
% http://www.cs.ubc.ca/~lowe/keypoints/)

% Your implementation does not need to exactly match the SIFT reference.
% Here are the key properties your (baseline) descriptor should have:
%  (1) a 4x4 grid of cells, each feature_width/4.
%  (2) each cell should have a histogram of the local distribution of
%    gradients in 8 orientations. Appending these histograms together will
%    give you 4x4 x 8 = 128 dimensions.
%  (3) Each feature should be normalized to unit length
%
% You do not need to perform the interpolation in which each gradient
% measurement contributes to multiple orientation bins in multiple cells
% As described in Szeliski, a single gradient measurement creates a
% weighted contribution to the 4 nearest cells and the 2 nearest
% orientation bins within each cell, for 8 total contributions. This type
% of interpolation probably will help, though.

% You do not have to explicitly compute the gradient orientation at each
% pixel (although you are free to do so). You can instead filter with
% oriented filters (e.g. a filter that responds to edges with a specific
% orientation). All of your SIFT-like feature can be constructed entirely
% from filtering fairly quickly in this way.

% You do not need to do the normalize -> threshold -> normalize again
% operation as detailed in Szeliski and the SIFT paper. It can help, though.

% Another simple trick which can help is to raise each element of the final
% feature vector to some power that is less than one.

%% Added by Ali Hassan (MSCS15049@itu.edu.pk)
num_ori = 8;
cell_size = round(feature_width / 4);

[ih, iw, ic] = size(image);

% [dx, dy] = get_edge_gradients(image);
% M = sqrt((dx.^2 + dy.^2));
% gradient  = atan2d( dy, dx);

[dx, dy] = imgradientxy(image);
[M, gradient] = imgradient(dx, dy);

% making orientation channels,
angle_step = 45;
angle = -180;
ori_imgs = zeros(ih, iw, num_ori);
for i=1:num_ori    
    idxs = find(gradient>=angle & gradient<=angle+angle_step);
    ori_t = zeros(size(gradient));
    ori_t(idxs) = 1;
    ori_t = ori_t .* M;
%     figure; imagesc(ori_t);
    ori_imgs(:,:,i) = ori_t;
    angle=angle+angle_step;
end

gf = fspecial('Gaussian', [feature_width/2, feature_width/2], feature_width/2);
ori_imgs = imfilter(ori_imgs, gf);

features = [];
for i = 1:length(x)
    block = ori_imgs(y(i):y(i)+feature_width-1, x(i):x(i)+feature_width-1, :);
    descriptor = [];
    for j = 0:cell_size:feature_width-cell_size        
        for k = 0:cell_size:feature_width-cell_size
            b = block(j+1:j+cell_size,k+1:k+cell_size,:);
            descriptor = [descriptor reshape(sum(sum(b)),1,length(b))];
        end
    end
    
    % Normalize
    descriptor = descriptor / norm(descriptor);     
    descriptor = descriptor .* (descriptor <= 0.6);
    descriptor = descriptor ./norm(descriptor);
    descriptor = descriptor.^0.5;  
    features(i,:) = descriptor;
end

end