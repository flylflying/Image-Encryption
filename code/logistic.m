%利用Logistic混沌映射，对灰度图像进行序列加密
function Fuck=logistic(picture,x0,u)
[M,N]=size(picture);
x=x0;
%迭代500次，达到充分混沌状态
for i=1:500
    x=u*x*(1-x);
end
%产生一维混沌加密序列
A=zeros(1,M*N);
A(1)=x;
for i=1:M*N-1
A(i+1)=u*A(i)*(1-A(i));
end
%归一化序列
B=uint8(255*A);
%转化为二维混沌加密序列
Fuck=reshape(B,M,N);
%完