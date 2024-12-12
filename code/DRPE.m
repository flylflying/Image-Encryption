
function C1=DRPE(I,z2,z3)

A=im2double(I);
% figure,imshow(A);title('The original image');
%producing mask1and mask2, encryption
A1=z2;
A11=exp(i*2*pi*A1);%mask1
A111=A.*A11;
B=fft2(A111);
B1=z3;
B11=exp(i*2*pi*B1);%mask2
B111=B.*B11;
C=ifft2(B111);
C1=abs(C);
figure;imshow(C1);title('The Encrypted image');

