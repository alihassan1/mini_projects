% Projection Matrix Stencil Code
% CS 4495 / 6476: Computer Vision, Georgia Tech
% Written by Henry Hu, Grady Williams, James Hays

% Returns the projection matrix for a given set of corresponding 2D and
% 3D points. 

% 'Points_2D' is nx2 matrix of 2D coordinate of points on the image
% 'Points_3D' is nx3 matrix of 3D coordinate of points in the world

% 'M' is the 3x4 projection matrix


function M = calculate_projection_matrix( Points_2D, Points_3D )

% To solve for the projection matrix. You need to setup a homogenous
% set of equations using the corresponding 2D and 3D points:

%                                                     [M11       [ u1
%                                                      M12         v1
%                                                      M13         .
%                                                      M14         .
%[ X1 Y1 Z1 1 0  0  0  0 -u1*X1 -u1*Y1 -u1*Z1          M21         .
%  0  0  0  0 X1 Y1 Z1 1 -v1*Z1 -v1*Y1 -v1*Z1          M22         .
%  .  .  .  . .  .  .  .    .     .      .          *  M23   =     .
%  Xn Yn Zn 1 0  0  0  0 -un*Xn -un*Yn -un*Zn          M24         .
%  0  0  0  0 Xn Yn Zn 1 -vn*Zn -vn*Yn -vn*Zn ]        M31         .
%                                                      M32         un
%                                                      M33         vn ]

% Then you can solve this using least squares with the '\' operator or SVD.
% Notice you obtain 2 equations for each corresponding 2D and 3D point
% pair. To solve this, you need at least 6 point pairs.

%% Implemented by Ali Hassan (mscs15049@itu.edu.pk)

num_pts = length(Points_2D);
if num_pts < 6
   error('Insufficient number of points, you need at least 6 correspondences to calculate projection matrix\n') 
end

method = 1; 
idx = 1;
rows = num_pts*2;   
if method == 0  % nonhomogeneous linear system
    A = zeros(rows, 11);
    Y = zeros(rows, 1);
    for i=1:2:rows
        A(i,1:4) = [Points_3D(idx, :) 1];
        A(i,end-2:end) = -Points_2D(idx, 1) .* Points_3D(idx, :);
        A(i+1,5:8) = [Points_3D(idx, :) 1];
        A(i+1,end-2:end) = -Points_2D(idx, 2) .* Points_3D(idx, :);

        Y(i:i+1,:) = Points_2D(idx, :)';
        idx = idx+1;
    end

    M = A\Y; 
    M = [M;1]; 
    M = reshape(M,[],3)';

else            % homogeneous linear system

    A = zeros(rows, 12);
    for i=1:2:rows
        A(i,1:4) = [Points_3D(idx, :) 1];
        A(i,end-3:end) = -Points_2D(idx, 1) .* [Points_3D(idx, :) 1];
        A(i+1,5:8) = [Points_3D(idx, :) 1];
        A(i+1,end-3:end) = -Points_2D(idx, 2) .* [Points_3D(idx, :) 1];
        idx = idx+1;
    end

    [U, S, V] = svd(A);
    p = V(:, end);
    M = reshape(p, 4, 3)';
end

