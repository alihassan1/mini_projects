% Camera Center Stencil Code
% CS 4495 / 6476: Computer Vision, Georgia Tech
% Written by Henry Hu, Grady Williams, James Hays

% Returns the camera center matrix for a given projection matrix

% 'M' is the 3x4 projection matrix
% 'Center' is the 1x3 matrix of camera center location in world coordinates

function [ Center ] = compute_camera_center( M )
%% Added by Ali Hassan (mscs15049@itu.edu.pk)
% Given the camera matrix M and the equation M = [Q | -QC], we have, 
Q = M(:,1:3);
QC = M(:,end);

Center = -inv(Q) * QC;

end