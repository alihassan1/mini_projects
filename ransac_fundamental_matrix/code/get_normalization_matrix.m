function [normPts, T] = get_normalization_matrix(pts)

if size(pts,1) == 2
    pts = [pts; ones(1,size(pts,2))];
end

if sum(isnan(pts(:))) || sum(isinf(pts(:)))
    error('points can not be on infinity')
end

centroid = mean(pts,2);
dists = sqrt(sum((pts - repmat(centroid,1,size(pts,2))).^2,1));
mean_dist = mean(dists);
T = [sqrt(2)/mean_dist 0 -sqrt(2)/mean_dist*centroid(1);...
            0 sqrt(2)/mean_dist -sqrt(2)/mean_dist*centroid(2);...
            0 0 1];
        
normPts = T*pts;
normPts = (normPts ./ repmat(normPts(3,:), 3,1))';

end