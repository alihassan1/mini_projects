function [inliers_a, inliers_b] = find_inliers(matches_a, matches_b, F, dist_threshold)

Fx1 = F*matches_a';
Ftx2 = F'*matches_b';

for n = 1:length(matches_a)
		x2tFx1(n) = matches_b(n,:)*F*matches_a(n,:)';
end
        
d =  x2tFx1.^2 ./ ...
		 (Fx1(1,:).^2 + Fx1(2,:).^2 + Ftx2(1,:).^2 + Ftx2(2,:).^2);
	    
inliers = find(abs(d) < dist_threshold);     % Indices of inlying points
inliers_a = matches_a(inliers,:);
inliers_b = matches_b(inliers,:);
end