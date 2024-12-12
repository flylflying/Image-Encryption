function psnrvalue = rgbPSNR(image1,image2)
% image1和image2大小相等
row=size(image1,1); % 图像的长
col=size(image1,2); % 图像的宽

MSE_R=double(zeros(row,col));
MSE_G=double(zeros(row,col));
MSE_B=double(zeros(row,col));
image1_R=image1(:,:,1);  % R通道
image1_G=image1(:,:,2);  % G通道
image1_B=image1(:,:,3);  % B通道
image2_R=image2(:,:,1);
image2_G=image2(:,:,2);
image2_B=image2(:,:,3);
% 计算RGB图像三个通道每个通道的MSE值再求平均值
for i=1:row
    for j=1:col
        MSE_R(i,j)=(image1_R(i,j)-image2_R(i,j))^2;
        MSE_G(i,j)=(image1_G(i,j)-image2_G(i,j))^2;
        MSE_B(i,j)=(image1_B(i,j)-image2_B(i,j))^2;
    end
end
MSE_RGB=sum(MSE_R(:))+sum(MSE_G(:))+sum(MSE_B(:)); % 将RGB三个通道计算的MSE值相加,注意(:)的用法
MSE=MSE_RGB/(row*col);
B=8;         % 编码一个像素所用二进制位数
MAX=2^B-1;   % 图像的灰度级数        
psnrvalue=20*log10(MAX/sqrt(MSE)); % 两个图像的峰值信噪比                     
end
