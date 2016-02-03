clear all;
clc;

% eisagwgi eikonas
I1 = imread('dog.png');
Rin = imref2d(size(I1));

% arxikopoiisi parametrwn
tx = 10;
ty = -2;
sx = 2;
sy = 1;
shy = 0;
shx = 0;
q = pi/18;

% pinakes twn metasximatismwn
translation = [ 1  0 0 ; 
                0  1 0 ; 
               tx ty 1 ];
scale = [ sx 0 0 ; 
          0 sy 0 ; 
          0  0  1 ];
shear = [ 1 shy 0 ; 
         shx  1 0 ; 
          0   0 1 ];
rotation = [ cos(q) sin(q) 0 ; 
            -sin(q) cos(q) 0 ; 
                 0      0  1 ];

% sinolikos pinakas metasximatismwn
trans = rotation * shear * scale * translation;
T = affine2d(trans);

% efarmogi tou metasximatismou panw stin eikona
[I2,Rout] = imwarp(I1, T, 'FillValues', 1);

% proboli tis arxikis kai tis telikis eikonas
figure, subplot(2,1,1);
imshow(I1,Rin), title('Original Image'); 
subplot(2,1,2);
imshow(I2,Rout), title('Transformed Image');