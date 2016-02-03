function [Im1, Im2, Im3] = myjpegcompression(Image)

% Image = imread('paparounes.bmp');
Image = rgb2ycbcr(Image);

I = Image(:,:,1);
I = double(I);
[mI,nI] = size(I);
mb = mI/8;
nb = nI/8;


%Demo block
m = 7;
n = 10;

%Afairesi tou 128
Is = I - 128;

%Efarmogi tou 2D-DCT se kathe block 8x8
fun = @dct2;
J = blkproc(Is, [8 8], fun);

Q = [ 16 11 10 16 24 40 51 61
      12 12 14 19 26 58 60 55
      14 13 16 24 40 57 69 56
      14 17 22 29 51 87 80 62
      18 22 37 56 68 109 103 77
      24 35 55 64 81 104 113 92
      49 64 78 87 103 121 120 101
      72 92 95 98 112 100 103 99];

% Q = [ 80 60 50 80 120 200 255 255
%       55 60 70 95 130 255 255 255
%       70 65 80 120 200 255 255 255
%       70 85 110 145 255 255 255 255
%       90 110 255 255 255 255 255 255
%       120 175 255 255 255 255 255 255
%       255 255 255 255 255 255 255 255
%       255 255 255 255 255 255 255 255 ];

%Kvantismos olwn twn sintelestwn
Jquant = round(blkproc(J, [8 8], 'divq', Q));
C = Jquant(1+8*m : 8+8*m, 1+8*n : 8+8*n);

%Antistrofi
%Efarmogi tou 2D-IDCT se kathe block 8x8
%fun2 = @idct2;

Jdquant = blkproc(Jquant, [8 8], 'multip',Q);
Iinv = blkproc(Jdquant, [8 8], 'idct2');

Iinv = Iinv + 128;
Im1 = round(Iinv);
% disp('Antistrofes times tou block me 128')
% round(Iinv(1+8*m : 8+8*m, 1+8*n : 8+8*n))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = Image(:,:,2);
I = double(I);
[mI,nI] = size(I);
mb = mI/8;
nb = nI/8;

%Demo block
m = 7;
n = 10;

%Afairesi tou 128
Is = I - 128;

%Efarmogi tou 2D-DCT se kathe block 8x8
fun = @dct2;
J = blkproc(Is, [8 8], fun);

B = J(1+8*m : 8+8*m, 1+8*n : 8+8*n);

Q = [ 17 18 24 47 99 99 99 99
      18 21 26 66 99 99 99 99
      24 26 56 99 99 99 99 99
      47 66 99 47 99 99 99 99
      99 99 99 99 99 99 99 99
      99 99 99 99 99 99 99 99
      99 99 99 99 99 99 99 99
      99 99 99 99 99 99 99 99 ];


%Kvantismos olwn twn sintelestwn
Jquant = round(blkproc(J, [8 8], 'divq', Q));
C = Jquant(1+8*m : 8+8*m, 1+8*n : 8+8*n);

%Antistrofi
%Efarmogi tou 2D-IDCT se kathe block 8x8
%fun2 = @idct2;

Jdquant = blkproc(Jquant, [8 8], 'multip',Q);
Iinv = blkproc(Jdquant, [8 8], 'idct2');

Iinv = Iinv + 128;
Im2 = round(Iinv);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = Image(:,:,3);
I = double(I);
[mI,nI] = size(I);
mb = mI/8;
nb = nI/8;

%Demo block
m = 7;
n = 10;

%Afairesi tou 128
Is = I - 128;


%Efarmogi tou 2D-DCT se kathe block 8x8
fun = @dct2;
J = blkproc(Is, [8 8], fun);

B = J(1+8*m : 8+8*m, 1+8*n : 8+8*n);


Q = [ 17 18 24 47 99 99 99 99
      18 21 26 66 99 99 99 99
      24 26 56 99 99 99 99 99
      47 66 99 47 99 99 99 99
      99 99 99 99 99 99 99 99
      99 99 99 99 99 99 99 99
      99 99 99 99 99 99 99 99
      99 99 99 99 99 99 99 99 ];

%Kvantismos olwn twn sintelestwn
Jquant = round(blkproc(J, [8 8], 'divq', Q));
C = Jquant(1+8*m : 8+8*m, 1+8*n : 8+8*n);

%Antistrofi
%Efarmogi tou 2D-IDCT se kathe block 8x8
%fun2 = @idct2;

Jdquant = blkproc(Jquant, [8 8], 'multip',Q);
Iinv = blkproc(Jdquant, [8 8], 'idct2');
Iinv = Iinv + 128;
Im3 = round(Iinv);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Im1 = uint8(Im1);
Im2 = uint8(Im2);
Im3 = uint8(Im3);

% figure(2)
% imshow(Im1)
% figure(3)
% imshow(Im2)
% figure(4)
% imshow(Im3)
% 
% Idec(:,:,1) = Im1;
% Idec(:,:,2) = Im2;
% Idec(:,:,3) = Im3;
% 
% Immm = ycbcr2rgb(Idec);
% 
% imshow((Immm))



