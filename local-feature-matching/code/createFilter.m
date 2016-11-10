function [dg_fx, dg_fy] = createFilter(sigma)

% house keeping
if (nargin < 1)
    sigma = 1;
end

if (sigma < 0.5)
    sigma = 0.5;
end

T = 0.1;

% sHalf = 2 * round(sqrt(-log(T) * 2 * sigma^2)) + 1;
sHalf = round(sqrt(-log(T) * 2 * sigma.^2));
x = floor(-sHalf*sigma):ceil(sHalf*sigma); % 2*sHalf + 1
gaus = exp(-0.5*x.^2/sigma.^2);
gaus = conv2(gaus, gaus');
% gaus = gaus./sum(gaus(:));

% maskY = -0.5*xx.*gaus/sigma^2;

% taking the 1st derivative
dg_fx = conv2(gaus, [1 0 -1]', 'same');

% scaling
dg_fx = dg_fx./max(dg_fx(:));
dg_fy = dg_fx';

end