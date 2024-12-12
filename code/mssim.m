function mssim = mssim(img1, img2)

P = img1;   %读图
R = P(:,:,1);        %提取明文图像的R层像素
G = P(:,:,2);        %提取明文图像的G层像素
B = P(:,:,3);        %提取明文图像的B层像素
F = img2;   %读图
r = F(:,:,1);        %提取明文图像的R层像素
g = F(:,:,2);        %提取明文图像的G层像素
b = F(:,:,3);        %提取明文图像的B层像素
mssim1= ssim_index(R,r,64);
mssim2= ssim_index(G,g,64);
mssim3= ssim_index(B,b,64);

mssim = (mssim1+mssim2+mssim3)/3;

return 