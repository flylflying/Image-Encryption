clc 
clear
close all

%% 预处理

imgOrg = double(imread('.\images\woman.bmp'));                              % 读文件  
[row,col] = size(imgOrg);
TS = 0;
r = 4/16;                                                                  % 压缩率                                                                                                                     % 偏移量
M = round(row*r);                                                          % 测量值取整数
[h0,h1,f0,f1] = daub(8);
basis2d = [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 ...
           3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]; 


%% 加密过程
tic;
%a = 2.987; cx0 = 0.678; cy0 = 0.496;                                       % 二维超混沌映射的初始值
%a = 10; cx0 = 0.00000678; cy0 = 4.96;
a = 0.98; cx0 = 67.8; cy0 = 0.346;                                           %新混沌系统最好的初值 
% key2 = key2+0.0000000000001;
%a = 0.98; cx0 = 67.8; cy0 = 0.346;                                           %新混沌系统最好的初值 
d = 30;                                                                    % 抽样长度
% catSeq = NewMap(d*(M*col/4)+4,a,cx0,cy0);
catSeq = chaotic(d*(M*col/4)+4,a,cx0,cy0);
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
% imgSpcon = Zigzagop(imgSp);
% %imgSpcon = enscramble_arnold(imgSpcon,z1);                                    % 系数矩阵Arnold置乱
% imgSpcon = Zigzagop(imgSpcon);
% imgSpcon = Zigzagop(imgSpcon);
imgMea = Phi*imgSpcon;                                                     % 测量
mmax = max(imgMea(:)); mmin = min(imgMea(:));
img_en = round(255*(imgMea-mmin)/(mmax-mmin));                             % 量化
img_en = uint8(img_en);
toc;
[row1,col1] = size(img_en);
%取得压缩图像
   img_en = reshape(img_en,256,256);
%   img_en = reshape(img_en,128,128);
imwrite(img_en,'clown.bmp');
%完

%%嵌入过程
img=imread('images/airplane.bmp');
% figure(6);
% imhist(uint8(img));
%小波分解
tic;
[m,m]=size(img);
imgwave=liftwavedec2(img,m,1);
a = mat2cell(imgwave,[m/2 m/2],[m/2 m/2]);
[A V D H] = deal(a{:});
H = double(H);
figure(1);
imshow(imgwave);
[P, H1] = hess(H);
[HUw, HSw, HVw] = svd(H1, 'econ');

[P1, H2] = hess(double(img_en));
[Uw, Sw, Vw] = svd(H2, 'econ');
%figure(2);
%subplot(2,2,1); imshow(A);
%subplot(2,2,2); imshow(V);
%subplot(2,2,3); imshow(D);
%subplot(2,2,4); imshow(H);

%嵌入
Hsta = HSw + 0.1.*Sw;
H_hat = HUw * Hsta * HVw';
LL_hat = P*H_hat*P';

imgwave = [A,V;D,LL_hat];

%逆小波运算
imgrec=liftwaverec2(imgwave,m,1);
imgrec = uint8(imgrec);
toc;
figure(2);
%    imgrec = noiseGauss(imgrec,0.00005);
%    imgrec = noiseSaltPepper(imgrec);
%    imgrec = noiseSpeckle(imgrec);
% imgrec = cropAttack(imgrec);
imshow(imgrec);
% figure(7);
% imhist(uint8(imgrec));
%imwrite(imgrec,'airplanerec.bmp')

[ssim,psnr] = PS(uint8(img),uint8(imgrec));                             % 计算性能
fprintf('The SSIM between carrier image and cytped image :\n ');                                                                                                              
disp(ssim);
fprintf('The PSNR between carrier image and cytped image :\n ');                                                                                                           
disp(psnr);


%%水印提取
tic;
imgrec = double(imgrec);
[m,m]=size(imgrec);
imgwave=liftwavedec2(imgrec,m,1);
a = mat2cell(imgwave,[m/2 m/2],[m/2 m/2]);
[A V D Hsta] = deal(a{:});
Hw = hess(Hsta);
[HUw_hat, HSbw_hat, HVw_hat] = svd(Hw);
img_en = (HSbw_hat - HSw)./0.1;
w_hat = Uw*img_en*Vw';
s_hat = P1*w_hat*P1';
img_en = uint8(s_hat);
toc;
%% 解密过程
%原代码
tic;
 imgEnc = double(img_en);   
%取得水印
  %imgEnc = double(imread('exact.bmp'));
 imgEnc = reshape(imgEnc,row1,col1);
%完
imgIqua = imgEnc*(mmax-mmin)/255+mmin;
for i = 1:col                                                              % 列循环 
%    imgIre(:,i) = OMP(imgIqua(:,i),Phi,round(M/4));                        % OMP重构算法
     imgIre(:,i) = SL0(Phi,imgIqua(:,i),0.004);                             % SL0重构算法  
 
end
toc;
imgIcon = descramble_arnold(imgIre,z1);                                     % 反置乱算法
% imgIcon = iZigzagop(imgIre);
% imgIcon = iZigzagop(imgIcon);
% imgIcon = iZigzagop(imgIcon);
imgIsp = iwpk2d(imgIcon,f0,f1,basis2d);
img_de = uint8(imgIsp);

%  imwrite(img_de,'fruitjiemi2.bmp')

%% 收尾处理
figure(3);
imshow(uint8(imgOrg)); title('原始图像'); 
figure(4);
imshow(uint8(img_en)); title('压缩图像');
figure(5);
imshow(uint8(img_de)); title('重建图像'); 
[ssim,psnr] = PS(uint8(img_de),uint8(imgOrg));                             % 计算性能
fprintf('The SSIM between plain image and decrypted image :\n ');                                                                                                              
disp(ssim);
fprintf('The PSNR between plain image and decrypted image :\n ');                                                                                                           
disp(psnr);
