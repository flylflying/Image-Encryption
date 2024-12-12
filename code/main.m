clc 
clear
close all

%% 预处理
imgOrg = im2gray(imread('.\image-test\car3.png'));
%imgOrg = double(imread('.\images\car1.bmp'));                              % 读文件  
[row,col] = size(imgOrg);
TS = 25;
r = 4/16;                                                                  % 压缩率                                                                                                                     % 偏移量
M = round(row*r);                                                          % 测量值取整数
[h0,h1,f0,f1] = daub(8);
basis2d = [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]; 


%% 加密过程
%a = 2.987; cx0 = 0.678; cy0 = 0.496;                                       % 二维超混沌映射的初始值
%a = 10; cx0 = 0.00000678; cy0 = 4.96;
a = 0.98; cx0 = 67.8; cy0 = 0.346;                                           %新混沌系统最好的初值 
% key2 = key2+0.0000000000001;
%a = 0.98; cx0 = 67.8; cy0 = 0.346;                                           %新混沌系统最好的初值 
d = 30;                                                                    % 抽样长度
catSeq = NewMap(d*(M*col/4)+4,a,cx0,cy0);
%catSeq = Chebyshev(4,0.759,d*(M*col/4)+4);
catDeqcon = zeros(1,M*col/4);
for i = 1:M*col/4
    catDeqcon(i) = 1+2*catSeq(d*i);
end
catTmp = reshape(catDeqcon,M/2,col/2)*sqrt(4/M); 
IE = eye(2);
Phi = kron(catTmp,IE);                                                     % 产生测量矩阵 
Phi = reshape(Phi,M,col);
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
z1 = Lorenz_chaotic(0,2*row*col);                                          % 用于置乱

imgSp = wpk2d(imgOrg,h0,h1,basis2d);
imgSp(abs(imgSp) <= TS) = 0;                                               % 稀疏化
imgSpcon = enscramble_arnold(imgSp,z1);                                    % 系数矩阵Arnold置乱

% imgSpcon = Zigzagop(imgSpcon);
% imgSpcon = Zigzagop(imgSpcon);
% imgSpcon = Zigzagop(imgSpcon);
imgMea = Phi*imgSpcon;                                                     % 测量
mmax = max(imgMea(:)); mmin = min(imgMea(:));
img_en = round(255*(imgMea-mmin)/(mmax-mmin));                             % 量化
img_en = uint8(img_en);
[row1,col1] = size(img_en);
%取得压缩图像
img_en = reshape(img_en,256,256);
%imwrite(img_en,'clown.bmp');
%完



%%嵌入过程
CarrierImage=imread('images/couple.bmp');
%小波分解
[m,m]=size(CarrierImage);
imgwave=liftwavedec2(CarrierImage,m,1);
a = mat2cell(imgwave,[m/2 m/2],[m/2 m/2]);
[A V D H] = deal(a{:});
figure(1);
imshow(imgwave);

% WatermarketImg = LSB_Encode1(imgwave,img_en,m,m,256,256);
 WatermarketImg = LSB_Encode(imgwave,img_en,m,m,256,256);
figure(2),imshow(WatermarketImg);
%imgwave = [A,V;D,WatermarketImg];
%逆小波运算
imgrec=liftwaverec2(WatermarketImg,m,1);
figure(3);
imshow(imgrec);
[ssim,psnr] = PS(uint8(CarrierImage),uint8(imgrec));                             % 计算性能
fprintf('The SSIM between carrier image and cytped image :\n ');                                                                                                              
disp(ssim);
fprintf('The PSNR between carrier image and cytped image :\n ');                                                                                                           
disp(psnr);

%%噪声攻击
%      imgrec = noiseGauss(imgrec,0.000005);
%     imgrec = noiseSaltPepper(imgrec);
%    imgrec = noiseSpeckle(imgrec);
%  imgrec = cropAttack(imgrec);

%%水印提取
imgrec = double(imgrec);
[m,m]=size(imgrec);
imgwave1=liftwavedec2(imgrec,m,1);
imgwave1 = uint8(imgwave1);
a = mat2cell(imgwave1,[m/2 m/2],[m/2 m/2]);
[A V D Hsta] = deal(a{:});

%  img_en1 = uint8(LSB_Decode1(imgwave1,256,256));
 img_en1 = uint8(LSB_Decode(imgwave1,256,256));

%% 解密过程
%原代码
 imgEnc = double(img_en1);   
%取得水印
  %imgEnc = double(imread('exact.bmp'));
 imgEnc = reshape(imgEnc,row1,col1);
%完
imgIqua = imgEnc*(mmax-mmin)/255+mmin;
for i = 1:col                                                              % 列循环 
   %imgIre(:,i) = OMP(imgIqua(:,i),Phi,round(M/4));                        % OMP重构算法
    imgIre(:,i) = SL0(Phi,imgIqua(:,i),0.004);                             % SL0重构算法  
 
end
% imgIcon = iZigzagop(imgIre);
% imgIcon = iZigzagop(imgIcon);
% imgIcon = iZigzagop(imgIcon);
imgIcon = descramble_arnold(imgIre,z1);                                     % 反置乱算法

imgIsp = iwpk2d(imgIcon,f0,f1,basis2d);
img_de = uint8(imgIsp);
%  imwrite(img_de,'fruitjiemi2.bmp')

%% 收尾处理
figure(4);
imshow(uint8(imgOrg)); title('原始图像'); 
figure(5);
imshow(uint8(img_en)); title('压缩图像');
figure(6);
imshow(uint8(img_de)); title('重建图像'); 
[ssim,psnr] = PS(uint8(img_de),uint8(imgOrg));                             % 计算性能
fprintf('The SSIM between plain image and decrypted image :\n ');                                                                                                              
disp(ssim);
fprintf('The PSNR between plain image and decrypted image :\n ');                                                                                                           
disp(psnr);