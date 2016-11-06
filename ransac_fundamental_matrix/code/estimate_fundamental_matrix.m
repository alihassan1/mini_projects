function [ F_matrix ] = estimate_fundamental_matrix(Points_a,Points_b)

num_pts = length(Points_a);
if num_pts < 8
    error('At least 8 correspondences are required to compute the fundamental matrix');
end
    
if num_pts ~= length(Points_b)
    error('Length of the both corresponding arrays must be equal');
end

[Points_a, T] = get_normalization_matrix(Points_a');
[Points_b, Tb]= get_normalization_matrix(Points_b');

A = [Points_a(:,1).*Points_b(:,1)  Points_b(:,1).*Points_a(:,2) ...
         Points_b(:,1) Points_b(:,2).*Points_a(:,1) Points_b(:,2).*Points_a(:,2) ...
         Points_b(:,2) Points_a(:,1) Points_a(:,2) ones(num_pts,1)];

[U, S, V] = svd(A); 
f = V(:, end); 
F = reshape(f, [3 3])';

[U, S, V] = svd(F); 
S(3,3) = 0; 
F_matrix = U*S*V';

F_matrix = Tb' * F_matrix * T;
end