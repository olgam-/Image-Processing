clear all;
clc;

% eisagwgi eikonas
I1 = imread('dog.png');

% arxikopoiisi parametrwn
theta = 45;
a = cosd(theta);
b = -sind(theta);
c = 0.001;
d = sind(theta);
e = cosd(theta);
f = 0.01;
g = 2;
h = 5;
i = 1;

% pinakas metasximatismou
T = [ a b c;
      d e f;
      g h i];
% T = [10  0  0.008;
%      2  4  0.01;
%      0  5  1   ];
tform = projective2d(T);

% efarmogi tou metasximatismou panw stin eikona
I2 = imwarp(I1,tform);

% proboli tis arxikis kai tis telikis eikonas
figure, subplot(2,1,1);
imshow(I1), title('Original Image');
subplot(2,1,2);
imshow(I2), title('Transformed Image');
