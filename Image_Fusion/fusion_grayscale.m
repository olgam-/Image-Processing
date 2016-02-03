clear all;
clc

Im1 = imread('planes1.jpg');
Im2 = imread('planes2.jpg');
Im3 = imread('planes3.jpg');

wavetype = 'db2';
[C1, P1] = wavedec2(Im1, 2, wavetype);
[C2, P2] = wavedec2(Im2, 2, wavetype);
[C3, P3] = wavedec2(Im3, 2, wavetype);

[H11, V11, D11] = detcoef2('all', C1, P1, 1);
[H21, V21, D21] = detcoef2('all', C2, P2, 1);
[H31, V31, D31] = detcoef2('all', C3, P3, 1);

A12 = appcoef2(C1, P1, wavetype, 2);
A22 = appcoef2(C2, P2, wavetype, 2);
A32 = appcoef2(C3, P3, wavetype, 2);

[H12, V12, D12] = detcoef2('all', C1, P1, 2);
[H22, V22, D22] = detcoef2('all', C2, P2, 2);
[H32, V32, D32] = detcoef2('all', C3, P3, 2);

A2r = max(max(A12,A22),A32);
H2r = max(max(H12,H22),H32);
V2r = max(max(V12,V22),V32);
D2r = max(max(D12,D22),D32);
H1r = max(max(H11,H21),H31);
V1r = max(max(V11,V21),V31);
D1r = max(max(D11,D21),D31);

A2r = reshape(A2r, 1, P1(1,1) * P1(1,2));
H2r = reshape(H2r, 1, P1(1,1) * P1(1,2));
V2r = reshape(V2r, 1, P1(1,1) * P1(1,2));
D2r = reshape(D2r, 1, P1(1,1) * P1(1,2));
H1r = reshape(H1r, 1, P1(3,1) * P1(3,2));
V1r = reshape(V1r, 1, P1(3,1) * P1(3,2));
D1r = reshape(D1r, 1, P1(3,1) * P1(3,2));
C = [A2r, H2r, V2r, D2r, H1r, V1r, D1r];

I_new = waverec2( C, P1, wavetype);

ImFinal = uint8(I_new);

figure(1), subplot(1,3,1);
imshow(Im1), title('Image 1'); 
subplot(1,3,2);
imshow(Im2), title('Image 2'); 
subplot(1,3,3);
imshow(Im3), title('Image 3'); 
figure(2)
imshow(ImFinal), title('Image after the fusion'); 

% figure(1), imshow(Im1);
% figure(2), imshow(Im2);
% figure(3), imshow(Im3);
% figure(4), imshow(ImFinal);
