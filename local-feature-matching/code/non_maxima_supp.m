function q_img = non_maxima_supp(gradient,M)
q_img = zeros(size(gradient));

% [0 to 22.5] [157.5 to 202.5] [337.5 to 360] - horizontal direction
a = gradient < 22.5;
b = gradient > 157.5 & gradient < 202.5;
c = gradient > 337.5 & gradient <= 360;
q_img(a) = 1;
q_img(b) = 1;
q_img(c) = 1;

a = conv2(M, [0 1 -1]', 'same');
b = conv2(M, [-1 1 0]', 'same');
c = (a > 0) & (b > 0);
md1 = (q_img == 1) & c;

% 22.5 to 67.5 - 202.5 to 247.5
a = gradient > 22.5 & gradient < 67.5;
b = gradient > 202.5 & gradient < 247.5;
q_img(a) = 2;
q_img(b) = 2;

a = conv2(M, [-1 0 0; 0 1 0; 0 0 0], 'same');
b = conv2(M, [0 0 0; 0 1 0; 0 0 -1], 'same');
c = (a > 0) & (b > 0);
md2 = (q_img == 2) & c;

% 67.5 to 112.5 - 247.5 to 292.5
a = gradient > 67.5 & gradient < 112.5;
b = gradient > 247.5 & gradient < 292.5;
q_img(a) = 3;
q_img(b) = 3;

a = conv2(M, [0 1 -1], 'same');
b = conv2(M, [-1 1 0], 'same');
c = (a > 0) & (b > 0);
md3 = (q_img == 3) & c;

% 112.5 to 157.5 - 292.5 to 337.5
a = gradient > 112.5 & gradient < 157.5;
b = gradient > 292.5 & gradient < 337.5;

q_img(a) = 4;
q_img(b) = 4;

a = conv2(M, [0 0 -1; 0 1 0; 0 0 0], 'same');
b = conv2(M, [0 0 0; 0 1 0; -1 0 0], 'same');
c = (a > 0) & (b > 0);
md4 = (q_img == 4) & c;

epxl = md1 | md2 | md3 | md4;
M2 = zeros(size(M));
M2(epxl) = M(epxl);

idx = M < 10;
q_img(idx) = -1;
end