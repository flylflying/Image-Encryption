% close all
% clear all
% clc
%I = im2gray(imread('.\images\CT.bmp'));
I = im2double(imread('.\images\baboon.bmp'));
figure;imshow(I);
[mraw,ncol] = size(I);
imageAverageGray = sum(sum(I))/(mraw*ncol)

% 求一副灰度图像的方差
% i=imread('灰度.jpg'); %载入灰度图像
% i=double(i);  %将uint8型转换为double型，否则不能计算统计量
% % sq1=var(i,0,1); %列向量方差，第二个参数为0，表示方差公式分子下面是n-1,如果为1则是n
% % sq2=var(i,0,2); %行向量方差
avg=mean2(I);  %求图像均值
[m,n]=size(I);
s=0;
for x=1:m
    for y=1:n
    s=s+(I(x,y)-avg)^2; %求得所有像素与均值的平方和。
    end
end
%求图像的方差
a=var(I(:)) %利用函数var求得。
