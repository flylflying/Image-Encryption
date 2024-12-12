clc 
clear
close all

%% 预处理

imgOrg = double(imread('.\image-test\car55.jpg'));                              % 读文件  
% imgOrg1 = double(imread('.\images\airplane.bmp'));  
% imgOrg2 = double(imread('.\images\Brain.bmp'));  
% imgOrg3 = double(imread('.\images\Barbara.bmp'));  
[row,col] = size(imgOrg);
% [row,col] = size(imgOrg1);
imgOrg1=imgOrg(:,:,1);%R
imgOrg2=imgOrg(:,:,2);%G
imgOrg3=imgOrg(:,:,3);%B
% imgOrg1(134,10)= imgOrg1(134,10)+2;
% imgOrg2(134,10)= imgOrg2(134,10)+2;
% imgOrg3(134,10)= imgOrg3(134,10)+2;
% imgOrg1(14,14)= imgOrg1(14,14)-2;
% imgOrg2(14,14)= imgOrg2(14,14)-2;
% imgOrg3(14,14)= imgOrg3(14,14)-2;
% imgOrg(:,:,1)=imgOrg1(:,:,1);
% imgOrg(:,:,2)=imgOrg2(:,:,1);
% imgOrg(:,:,3)=imgOrg3(:,:,1);
TS = 25;
r = 4/16;                                                                  % 压缩率                                                                                                                     % 偏移量
M = round(row*r);                                                          % 测量值取整数
[h0,h1,f0,f1] = daub(8);
basis2d = [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]; 


%%
%%密钥生成 
    H=HashFunction(imgOrg,'SHA-512'); 
    KeyHex = '7f4e9f6847484a87826d30a76b6522479b3e6128df984ad0c91b1711c52176c1';
    KeyDecimal = HashtoDecimal(KeyHex,H);
    k = zeros(1,8);
    for i = 1:7
        for j = i:4*i
        k(i) = bitxor(KeyDecimal(j),KeyDecimal(j+1));
        k(i) = bitxor(k(i),KeyDecimal(j+2));
        k(i) = bitxor(k(i),KeyDecimal(j+3));
        end
    end
    k(8)= bitxor(KeyDecimal(31),KeyDecimal(32));
    for i = 1:8
        k(i) = k(i).^(1/8);
    end
    a = mod(sqrt(k(1)*k(2)),5);
    cx0 = mod(sqrt(k(3)*k(4)),5)+20;
    cy0 = mod(sqrt(k(5)*k(6)),1);
    delta = mod(sqrt(k(7)*k(8))*row,5)+0.5;
%% 加密过程
tic;
%a = 2.987; cx0 = 0.678; cy0 = 0.496;                                       % 二维超混沌映射的初始值
%a = 10; cx0 = 0.00000678; cy0 = 4.96;
 delta = delta+0.00000000000001;
% a = 1.8; cx0 = key2; cy0 = key1;                                         %新混沌系统最好的初值 

% a = 0.98; cx0 = 67.8; cy0 = 0.346;                                           %新混沌系统最好的初值 
d = 30;                                                                    % 抽样长度
catSeq = chaotic(d*(M*row/4)+4,a,cx0,cy0);
% SE = SampEn(catSeq);
%catSeq = Chebyshev(4,0.759,d*(M*col/4)+4);
catDeqcon = zeros(1,M*row/4);
for i = 1:M*row/4
    catDeqcon(i) = 1+2*catSeq(d*i);
end
catTmp = reshape(catDeqcon,M/2,row/2)*sqrt(4/M); 
IE = eye(2);
Phi = kron(catTmp,IE);                                                     % 产生测量矩阵 
Phi = reshape(Phi,M,row);
%% 
 %svd优化
  [HUw, HSw, HVw] = svd(Phi, 'econ');
    vec = diag(HSw);
   M = mean(vec);
   vec(:) = M;
   HSw = diag(vec);
    Phi = HUw * HSw * HVw';
%end
%% 
%列向量单位化
 [m,n]=size(Phi);
 for i=1:n
     A(1,i)=norm(Phi(:,i));
  end
   A=repmat(A,m,1);
   Phi=Phi./A;
   
%% 
 z1 = Lorenz_chaotic(delta,2*row*row);                                          % 用于置乱
% z1 = fix(chaotic(2*row*row,a,cx0,cy0)*10);
% z1 = Lorenz_chaotic(0,2*row);     
% SE = SampEn(z1, 2, 0.2);
imgSp1 = wpk2d(imgOrg1,h0,h1,basis2d);
imgSp2 = wpk2d(imgOrg2,h0,h1,basis2d);
imgSp3 = wpk2d(imgOrg3,h0,h1,basis2d);
imgSp1(abs(imgSp1) <= TS) = 0;                                               % 稀疏化
imgSp2(abs(imgSp2) <= TS) = 0;    
imgSp3(abs(imgSp3) <= TS) = 0;    
imgSpcon1 = enscramble_arnold(imgSp1,z1);                                    % 系数矩阵Arnold置乱
imgSpcon2 = enscramble_arnold(imgSp2,z1); 
imgSpcon3 = enscramble_arnold(imgSp3,z1); 
[imgSpcon1, imgSpcon2, imgSpcon3] = Encode(imgSpcon1, imgSpcon2, imgSpcon3);
[imgSpcon1, imgSpcon2, imgSpcon3] = Encode(imgSpcon1, imgSpcon2, imgSpcon3);
[imgSpcon1, imgSpcon2, imgSpcon3] = Encode(imgSpcon1, imgSpcon2, imgSpcon3);
% imgSpcon = Zigzagop(imgSp);
% %imgSpcon = enscramble_arnold(imgSpcon,z1);                                    % 系数矩阵Arnold置乱
% imgSpcon = Zigzagop(imgSpcon);
% imgSpcon = Zigzagop(imgSpcon);
imgMea1 = Phi*imgSpcon1;                                                     % 测量
imgMea2 = Phi*imgSpcon2;   
imgMea3 = Phi*imgSpcon3;   
mmax1 = max(imgMea1(:)); mmin1 = min(imgMea1(:));
mmax2 = max(imgMea2(:)); mmin2 = min(imgMea2(:));
mmax3 = max(imgMea3(:)); mmin3 = min(imgMea3(:));
img_en1 = round(255*(imgMea1-mmin1)/(mmax1-mmin1));                             % 量化
img_en2 = round(255*(imgMea2-mmin2)/(mmax2-mmin2));  
img_en3 = round(255*(imgMea3-mmin3)/(mmax3-mmin3));  
img_en1 = reshape(img_en1,256,256);
img_en2 = reshape(img_en2,256,256);
img_en3 = reshape(img_en3,256,256);
img_en1 = uint8(img_en1);
img_en2 = uint8(img_en2);
img_en3 = uint8(img_en3);
img_en(:,:,1)=img_en1(:,:,1);
img_en(:,:,2)=img_en2(:,:,1);
img_en(:,:,3)=img_en3(:,:,1);
toc;
% r = ImCoef1(img_en1,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r);
% 
% r1 = ImCoef1(img_en2,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r1);
% 
% r2 = ImCoef1(img_en3,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r2);

figure;
imshow(img_en);
% imwrite(img_en,'CAR2.bmp');

% [row1,col1] = size(img_en);
%%嵌入过程
img=imread('image-test/Barnfall(1).jpg');
figure;
imhist(uint8(img));
img1=img(:,:,1);%R
img2=img(:,:,2);%G
img3=img(:,:,3);%B
% 
% r = ImCoef1(img1,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r);
% 
% r1 = ImCoef1(img2,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r1);
% 
% r2 = ImCoef1(img3,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r2);

% img_en=imread('image-test/加密后的lena.png');
% img_en1=img_en(:,:,1);%R
% img_en2=img_en(:,:,2);%G
% img_en3=img_en(:,:,3);%B
 figure(6);
 imhist(uint8(img));
%小波分解

%% [m,m]=size(img1);
 m=512;
 imgwave1=liftwavedec2(img1,m,1);
%  WatermarketImg1 = LSB_Encode(imgwave1,img_en1,m,m,256,256)
%  a = mat2cell(imgwave1,[m/2 m/2],[m/2 m/2]);
%  [A V D H] = deal(a{:});
% H = double(H);
% % [P, H1] = hess(H);
% [HUw, HSw, HVw] = svd(H, 'econ');
% 
% % [P1, H2] = hess(double(img_en1));
% [Uw, Sw, Vw] = svd(double(img_en1), 'econ');
% %figure(2);
% %subplot(2,2,1); imshow(A);
% %subplot(2,2,2); imshow(V);
% %subplot(2,2,3); imshow(D);
% %subplot(2,2,4); imshow(H);
% 
% %嵌入
% Hsta = HSw + 0.1.*Sw;
% H_hat = HUw * Hsta * HVw';
% % LL_hat = P*H_hat*P';
% 
% imgwave1 = [A,V;D,H_hat];
% 
% %逆小波运算
% WatermarketImg1=liftwaverec2(WatermarketImg1,m,1);
% WatermarketImg1 = uint8(WatermarketImg1);
% 
% %%水印提取
% tic;
% imgrec1 = double(imgrec1);
% % [m,m]=size(imgrec);
% imgwave1=liftwavedec2(imgrec1,m,1);
% a = mat2cell(imgwave1,[m/2 m/2],[m/2 m/2]);
% [A V D Hsta] = deal(a{:});
% % Hw = hess(Hsta);
% [HUw_hat, HSbw_hat, HVw_hat] = svd(Hsta);
% img_en = (HSbw_hat - HSw)./0.1;
% w_hat = Uw*img_en*Vw';
% % s_hat = P1*w_hat*P1';
% img_en1 = uint8(w_hat);
% 
% %小波分解
% tic;
% % [m,m]=size(img2);
% m=512;
 imgwave2=liftwavedec2(img2,m,1);
%  WatermarketImg2 = LSB_Encode(imgwave2,img_en2,m,m,256,256);
%  WatermarketImg2=liftwaverec2(WatermarketImg2,m,1);
%  WatermarketImg2 = uint8(WatermarketImg2);
% a = mat2cell(imgwave2,[m/2 m/2],[m/2 m/2]);
% [A V D H] = deal(a{:});
% H = double(H);
% % [P, H1] = hess(H);
% [HUw, HSw, HVw] = svd(H, 'econ');
% 
% % [P1, H2] = hess(double(img_en2));
% [Uw, Sw, Vw] = svd(double(img_en2), 'econ');
% %figure(2);
% %subplot(2,2,1); imshow(A);
% %subplot(2,2,2); imshow(V);
% %subplot(2,2,3); imshow(D);
% %subplot(2,2,4); imshow(H);
% 
% %嵌入
% Hsta = HSw + 0.1.*Sw;
% H_hat = HUw * Hsta * HVw';
% % LL_hat = P*H_hat*P';
% 
% imgwave2 = [A,V;D,H_hat];
% 
% %逆小波运算
% imgrec2=liftwaverec2(imgwave2,m,1);
% imgrec2 = uint8(imgrec2);
% 
% %%水印提取
% tic;
% imgrec2 = double(imgrec2);
% % [m,m]=size(imgrec);
% imgwave2=liftwavedec2(imgrec2,m,1);
% a = mat2cell(imgwave2,[m/2 m/2],[m/2 m/2]);
% [A V D Hsta] = deal(a{:});
% % Hw = hess(Hsta);
% [HUw_hat, HSbw_hat, HVw_hat] = svd(Hsta);
% img_en = (HSbw_hat - HSw)./0.1;
% w_hat = Uw*img_en*Vw';
% % s_hat = P1*w_hat*P1';
% img_en2 = uint8(w_hat);
% 
% %小波分解
% tic;
% % [m,m]=size(img3);
% m=512;
 imgwave3=liftwavedec2(img3,m,1);
%  WatermarketImg3 = LSB_Encode(imgwave3,img_en3,m,m,256,256);
%  WatermarketImg3=liftwaverec2(WatermarketImg3,m,1);
%  WatermarketImg3 = uint8(WatermarketImg3);
% a = mat2cell(imgwave3,[m/2 m/2],[m/2 m/2]);
% [A V D H] = deal(a{:});
% H = double(H);
% % [P, H1] = hess(H);
% [HUw, HSw, HVw] = svd(H, 'econ');
% 
% % [P1, H2] = hess(double(img_en3));
% [Uw, Sw, Vw] = svd(double(img_en3), 'econ');
% %figure(2);
% %subplot(2,2,1); imshow(A);
% %subplot(2,2,2); imshow(V);
% %subplot(2,2,3); imshow(D);
% %subplot(2,2,4); imshow(H);
% 
% %嵌入
% Hsta = HSw + 0.1.*Sw;
% H_hat = HUw * Hsta * HVw';
% % LL_hat = P*H_hat*P';
% 
% imgwave3 = [A,V;D,H_hat];
% 
% %逆小波运算
% imgrec3=liftwaverec2(imgwave3,m,1);
% imgrec3 = uint8(imgrec3);
% 
% %%水印提取
% tic;
% imgrec3 = double(imgrec3);
% % [m,m]=size(imgrec);
% imgwave3=liftwavedec2(imgrec3,m,1);
% a = mat2cell(imgwave3,[m/2 m/2],[m/2 m/2]);
% [A V D Hsta] = deal(a{:});
% % Hw = hess(Hsta);
% [HUw_hat, HSbw_hat, HVw_hat] = svd(Hsta);
% img_en = (HSbw_hat - HSw)./0.1;
% w_hat = Uw*img_en*Vw';
% % s_hat = P1*w_hat*P1';
%%img_en3 = uint8(w_hat);
%%
%   WatermarketImg1 = LSB_Encode(imgwave1,img_en1,m,m,256,256);
%   WatermarketImg2 = LSB_Encode(imgwave2,img_en2,m,m,256,256);
%   WatermarketImg3 = LSB_Encode(imgwave3,img_en3,m,m,256,256);

  WatermarketImg1 = LSB_Encode(img1,img_en1,m,m,256,256);
  WatermarketImg2 = LSB_Encode(img2,img_en2,m,m,256,256);
  WatermarketImg3 = LSB_Encode(img3,img_en3,m,m,256,256);
  
WatermarketImg(:,:,1)=WatermarketImg1(:,:,1);
WatermarketImg(:,:,2)=WatermarketImg2(:,:,1);
WatermarketImg(:,:,3)=WatermarketImg3(:,:,1);
  
% Z=imsubtract(uint8(img),uint8(WatermarketImg));

% figure(7);
% imshow(Z);

% figure;
% imhist(uint8(Z));
% 
% r = ImCoef1(WatermarketImg1,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r);
% 
% r1 = ImCoef1(WatermarketImg2,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r1);
% 
% r2 = ImCoef1(WatermarketImg3,3000);                             % 计算性能
% fprintf('The r :\n ');                                                                                                              
% disp(r2);

%  imwrite(WatermarketImg,'wi.bmp');
figure(8);
imshow(WatermarketImg);

%        WatermarketImg = noiseGauss(WatermarketImg,0.0000005);
%       WatermarketImg = noiseSaltPepper(WatermarketImg);
%      WatermarketImg = noiseSpeckle(WatermarketImg);
%       WatermarketImg = cropRGB(WatermarketImg); 
  
%   imgrec1=liftwaverec2(WatermarketImg1,m,1);
%   imgrec2=liftwaverec2(WatermarketImg2,m,1);
%   imgrec3=liftwaverec2(WatermarketImg3,m,1);
%  imgrec(:,:,1)=imgrec1(:,:,1);
%  imgrec(:,:,2)=imgrec2(:,:,1);
%  imgrec(:,:,3)=imgrec3(:,:,1);
% 
% %     imgrec = noiseGauss(imgrec,0.000000001);
%     imgrec = noiseSaltPepper(imgrec);
% %    imgrec = noiseSpeckle(imgrec);
%   imgrec = cropAttack(imgrec);
% imgrec = cropRGB(imgrec);
% 
% figure;
% imshow(uint8(imgrec));

%   figure(9);
%   imhist(uint8(WatermarketImg));
 
 %%水印提取
% imgrec = double(imgrec);
% imgrec1=imgrec(:,:,1);%R
% imgrec2=imgrec(:,:,2);%G
% imgrec3=imgrec(:,:,3);%B
% [m,m]=size(imgrec1);
% imgwave1=liftwavedec2(imgrec1,m,1);
% imgwave1 = uint8(imgwave1);
% imgwave2=liftwavedec2(imgrec2,m,1);
% imgwave2 = uint8(imgwave2);
% imgwave3=liftwavedec2(imgrec3,m,1);
% imgwave3 = uint8(imgwave3);
% a1 = mat2cell(imgwave1,[m/2 m/2],[m/2 m/2]);
% a2 = mat2cell(imgwave2,[m/2 m/2],[m/2 m/2]);
% a3 = mat2cell(imgwave3,[m/2 m/2],[m/2 m/2]);
% [A V D Hsta] = deal(a1{:});
% [A V D Hsta] = deal(a2{:});
% [A V D Hsta] = deal(a3{:});
%  img_en1 = uint8(LSB_Decode1(imgwave1,256,256));
%  img_en1 = uint8(LSB_Decode(imgwave1,256,256));
%  img_en2 = uint8(LSB_Decode(imgwave2,256,256));
%  img_en3 = uint8(LSB_Decode(imgwave3,256,256));
% WatermarketImg = imread('wi.bmp');
WatermarketImg1=WatermarketImg(:,:,1);%R
WatermarketImg2=WatermarketImg(:,:,2);%G
WatermarketImg3=WatermarketImg(:,:,3);%B

% WatermarketImg1=liftwavedec2(WatermarketImg1,m,1);
% WatermarketImg1 = uint8(WatermarketImg1);
% WatermarketImg2=liftwavedec2(WatermarketImg2,m,1);
% WatermarketImg2 = uint8(WatermarketImg2);
% WatermarketImg3=liftwavedec2(WatermarketImg3,m,1);
% WatermarketImg3 = uint8(WatermarketImg3);


 img_en1 = uint8(LSB_Decode(WatermarketImg1,256,256));
 img_en2 = uint8(LSB_Decode(WatermarketImg2,256,256));
 img_en3 = uint8(LSB_Decode(WatermarketImg3,256,256));
 

tic;
imgEnc1 = double(img_en1);   
imgEnc2 = double(img_en2);
imgEnc3 = double(img_en3);
%取得水印
  %imgEnc = double(imread('exact.bmp'));
  row1 = 128;
  col1 = 512;
 imgEnc1 = reshape(imgEnc1,row1,col1);
 imgEnc2 = reshape(imgEnc2,row1,col1);
 imgEnc3 = reshape(imgEnc3,row1,col1);
%完
imgIqua1 = imgEnc1*(mmax1-mmin1)/255+mmin1;
imgIqua2 = imgEnc2*(mmax2-mmin2)/255+mmin2;
imgIqua3 = imgEnc3*(mmax3-mmin3)/255+mmin3;
for i = 1:col1                                                              % 列循环 
%    imgIre(:,i) = OMP(imgIqua(:,i),Phi,round(M/4));                        % OMP重构算法
     imgIre1(:,i) = SL0(Phi,imgIqua1(:,i),0.004);                             % SL0重构算法  
 
end
for i = 1:col1                                                              % 列循环 
%    imgIre(:,i) = OMP(imgIqua(:,i),Phi,round(M/4));                        % OMP重构算法
     imgIre2(:,i) = SL0(Phi,imgIqua2(:,i),0.004);                             % SL0重构算法  
 
end
for i = 1:col1                                                              % 列循环 
%    imgIre(:,i) = OMP(imgIqua(:,i),Phi,round(M/4));                        % OMP重构算法
     imgIre3(:,i) = SL0(Phi,imgIqua3(:,i),0.004);                             % SL0重构算法  
 
end
toc;
[imgIre1, imgIre2, imgIre3] = Decode(imgIre1, imgIre2, imgIre3);
[imgIre1, imgIre2, imgIre3] = Decode(imgIre1, imgIre2, imgIre3);
[imgIre1, imgIre2, imgIre3] = Decode(imgIre1, imgIre2, imgIre3);
imgIcon1 = descramble_arnold(imgIre1,z1);                                     % 反置乱算法
imgIcon2 = descramble_arnold(imgIre2,z1);  
imgIcon3 = descramble_arnold(imgIre3,z1);  
% imgIcon = iZigzagop(imgIre);
% imgIcon = iZigzagop(imgIcon);
% imgIcon = iZigzagop(imgIcon);
imgIsp1 = iwpk2d(imgIcon1,f0,f1,basis2d);
imgIsp2 = iwpk2d(imgIcon2,f0,f1,basis2d);
imgIsp3 = iwpk2d(imgIcon3,f0,f1,basis2d);
img_de1 = uint8(imgIsp1);
img_de2 = uint8(imgIsp2);
img_de3 = uint8(imgIsp3);

img_de(:,:,1)=img_de1(:,:,1);
img_de(:,:,2)=img_de2(:,:,1);
img_de(:,:,3)=img_de3(:,:,1);


%   figure(10);
%   imhist(uint8(img_de));
   imwrite(img_de,'CAR2.bmp');

%% 收尾处理
figure(3);
imshow(uint8(imgOrg)); title('原始图像'); 
figure(5);
imshow(uint8(img_de)); title('重建图像'); 
% figure;
% imshow(uint8(img_de1)); title('重建图像');
% figure;
% imshow(uint8(img_de2)); title('重建图像'); 
% figure;
% imshow(uint8(img_de3)); title('重建图像');
psnr = rgbPSNR(uint8(img_de),uint8(imgOrg));                             % 计算性能
% fprintf('The SSIM between plain image and decrypted image :\n ');                                                                                                              
% disp(ssim);
fprintf('The PSNR between plain image and decrypted image :\n ');                                                                                                           
disp(psnr);


mssim = mssim(uint8(img_de),uint8(imgOrg));                             % 计算性能
fprintf('The ssim between plain image and decrypted image :\n ');                                                                                                              
disp(mssim);

 psnr = rgbPSNR(uint8(img),uint8(WatermarketImg));                             % 计算性能
% % fprintf('The SSIM between carrier image and cytped image :\n ');                                                                                                              
% % disp(ssim);
 fprintf('The PSNR between carrier image and cytped image :\n ');                                                                                                           
 disp(psnr);
 
mssim = ssim(uint8(img),uint8(WatermarketImg));                             % 计算性能
fprintf('The SSIM between carrier image and cytped image :\n ');                                                                                                              
disp(mssim);
%  fprintf('The PSNR between carrier image and cytped image :\n ');                                                                                                           
%  disp(psnr);

% [ssim,psnr5] = PS(uint8(img_de1),uint8(imgOrg1));                             % 计算性能
% fprintf('The SSIM between plain image and decrypted image :\n ');                                                                                                              
% disp(ssim);
% fprintf('The PSNR between plain image and decrypted image :\n ');                                                                                                           
% disp(psnr);
% 
% [ssim1,psnr1] = PS(uint8(img_de2),uint8(imgOrg2));                             % 计算性能
% fprintf('The SSIM between plain image and decrypted image :\n ');                                                                                                              
% disp(ssim);
% fprintf('The PSNR between plain image and decrypted image :\n ');                                                                                                           
% disp(psnr);
% [ssim2,psnr2] = PS(uint8(img_de3),uint8(imgOrg3));                             % 计算性能
% fprintf('The SSIM between plain image and decrypted image :\n ');                                                                                                              
% disp(ssim);
% fprintf('The PSNR between plain image and decrypted image :\n ');                                                                                                           
% disp(psnr);

