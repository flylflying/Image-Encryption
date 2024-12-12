%%
%decryption
function F=iDPRE(C,z2,z3)
%%
D=fft2(C);
A1=z2;
B1=z3;
D1=D.*exp(-i*2*pi*B1);
D11=ifft2(D1);
D111=D11.*exp(-i*2*pi*A1);
F=abs(D111);
figure,imshow(F);title('The decrypted image');