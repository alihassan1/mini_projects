function [ Best_Fmatrix, inliers_a, inliers_b] = ransac_fundamental_matrix(matches_a, matches_b)

num_corr = length(matches_a);
if num_corr < 8
    error('at least 8 correspondences are required to compute the fundamental matrix');
end

if(num_corr ~= length(matches_b))
    error('Length of the both corresponding arrays must be equal');
end

% Termination criteria
num_itr = 500;
percentage_inlier = 0.8; % threshold for a good match
dist_threshold = 1.5;

terminate = 1;
itr_counter = 0;
min_pts = 8;

number_of_inliers = [];
F_matrices = [];
idx = 1;

matches_a = [matches_a ones(num_corr,1)];
matches_b = [matches_b ones(num_corr,1)];

% indxs = randperm(num_corr);
while(terminate)
    indxs = randperm(num_corr, min_pts);
    m1 = []; m2 = [];
    for i = 1:min_pts
        m1(i,:) = matches_a(indxs(i), :);
        m2(i,:) = matches_b(indxs(i), :);
    end
    
    F = estimate_fundamental_matrix(m1, m2);
    
    [inlr_a, inlr_b] = find_inliers(matches_a, matches_b, F, dist_threshold);
    
    num_inlr = length(inlr_a);
    percent_inlr = num_inlr / num_corr;
    
    number_of_inliers(idx) = num_inlr;
    F_matrices{idx} = F;
    
    if itr_counter >= num_itr || percent_inlr >= percentage_inlier
        terminate = 0;
    end
    
    idx = idx+1;
    itr_counter = itr_counter+1;
    
end

[sc, idx] = max(number_of_inliers);
Best_Fmatrix = F_matrices{idx};

[inliers_a, inliers_b] = find_inliers(matches_a, matches_b, Best_Fmatrix, dist_threshold);

Best_Fmatrix = estimate_fundamental_matrix(inliers_a, inliers_b);
[inliers_a, inliers_b] = find_inliers(matches_a, matches_b, Best_Fmatrix, dist_threshold);
inliers_a = [inliers_a(:,1) inliers_a(:,2)];
inliers_b = [inliers_b(:,1) inliers_b(:,2)];

end