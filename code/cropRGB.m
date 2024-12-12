function cropImageAttacked = cropRGB(watermarked_image)
I=watermarked_image
%原图进行分色并剪切
N = 512;
cc = 128; %这里令中间的白色正方形大小为32*32
I_r= I(:,:,1);
% I_r(1:64,1:64)=0;
% I_r(1:64,449:512)=0;
% I_r(449:512,449:512)=0;
% I_r(449:512,1:64)=0;
I_r((N-cc)/2:(N+cc)/2,(N-cc)/2:(N+cc)/2)=0; %将中间变成白色，即赋值为255
I_g =I(:,:,2);
% I_g(1:64,1:64)=0;
% I_g(1:64,449:512)=0;
% I_g(449:512,449:512)=0;
% I_g(449:512,1:64)=0;
I_g((N-cc)/2:(N+cc)/2,(N-cc)/2:(N+cc)/2)=0; %将中间变成白色，即赋值为255
I_b =I(:,:,3);
% I_b(1:64,1:64)=0;
% I_b(1:64,449:512)=0;
% I_b(449:512,449:512)=0;
% I_b(449:512,1:64)=0;
I_b((N-cc)/2:(N+cc)/2,(N-cc)/2:(N+cc)/2)=0; %将中间变成白色，即赋值为255
% figure(1)
% subplot(221),imshow(I_r,[]),title('R通道剪切后图像');
% subplot(222),imshow(I_g,[]),title('G通道剪切后图像');
% subplot(223),imshow(I_b,[]),title('B通道剪切后图像');
%三色通道合并
cropImageAttacked(:,:,1) = I_r;
cropImageAttacked(:,:,2) = I_g;
cropImageAttacked(:,:,3) = I_b;
figure(1),imshow(cropImageAttacked,[]);
end
