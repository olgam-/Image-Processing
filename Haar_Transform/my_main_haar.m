clear;
clc;

I1 = imread('lenna.tif');
% I1 = imread('Nikos.png');
I2 = double(I1);
[M, N] = size(I2);

H = my_haar_transform(N);
I3 = H * I2 * H';

figure(1), imshow(I1)
title('Original image');

figure(2), imshow(I3,[0,255])
title('Haar transform');

I3(100:512 , 100:512) = 0;
I4 = H' * I3 * H;
I4 = uint8(I4);
figure(3), imshow(I4,[0,255])
title('Reconstructed image');
