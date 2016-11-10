function [dx, dy] = get_edge_gradients(image)

if nargin < 1
    error('Invalid input arguments.');
end

if size(image,3) ~=1
    error('This function only accepts grayscale image');
end

sigma = 1;
sc = 255;

[fx, fy] = createFilter(sigma);

fx = round(fx*sc);
fy = round(fy*sc);

dx = conv2(image, fx, 'same');
dy = conv2(image, fy, 'same');

end