function [C_R,C_G,C_B]= EncryDiffusion(P_R,P_G,P_B)
[M,N]=size(P_R);  %计算图片P尺寸大小


%% 第一部分
%产生混沌随机序列
n=2*M*N;      %计算所需要的序列长度
h=0.002; t=800;    
a=10; b=8/3; c=28; r =-1;   
x0=1.1; y0=2.2; z0=3.3; w0=4.4;
s=zeros(1,n);

tic;
%利用四阶龙格库塔法将超Lorenz混沌系统离散化的计算过程
for i=1:n+t
    K11=a*(y0-x0);               %x0表示xi
    K12=a*(y0-(x0+K11*h/2))+w0;
    K13=a*(y0-(x0+K12*h/2))+w0;
    K14=a*(y0-(x0+K13*h))+w0;
    x1=x0+(K11+2*K12+2*K13+K14)*h/6;    %x1表示xi+1
    
    K21=c*x1-y0-x1*z0;               
    K22=c*x1-(y0+K21*h/2)-x1*z0;
    K23=c*x1-(y0+K22*h/2)-x1*z0;
    K24=c*x1-(y0+K23*h)-x1*z0;
    y1=y0+(K21+2*K22+2*K23+K24)*h/6; 
    
    K31=x1*y1-b*z0;               
    K32=x1*y1-b*(z0+K31*h/2);
    K33=x1*y1-b*(z0+K32*h/2);
    K34=x1*y1-b*(z0+K33*h);
    z1=z0+(K31+2*K32+2*K33+K34)*h/6;
    
    K41=-y1*z1-r*w0;               
    K42=-y1*z1+r*(w0+K41*h/2);
    K43=-y1*z1+r*(w0+K42*h/2);
    K44=-y1*z1+r*(w0+K43*h);
    w1=z0+(K41+2*K42+2*K43+K44)*h/6;
    
    %把第i次的输出送给第i+1次的输入
    x0=x1;y0=y1;z0=z1;w0=w1;    
    
    %每3000次迭代后对混沌状态x0进行小的扰动
    if i>t
       s(i-t)=x1;
       if mod((i-t),3000)==0
        x0=x0+h*sin(x0);
       end
    end
 
end

%%
%s转化为整数类型的伪随机序列X,长度为M*N,整数不大于10*max(M,N)
X=mod(floor((s+100)*10^10),10*max(M,N))+1;
%用序列s生成2*M*N的扩散伪随机序列S
S=mod(floor(s*pow2(16)),256);

%%
a=X(1:M*N);          %用向量X生成M*N的置乱伪随机序列a,b
b=X(M*N+1:2*M*N);
S1=S(1:M*N);         %用于正向扩散的伪随机序列,即密码
S2=S(M*N+1:2*M*N);   %用于逆向扩散的伪随机序列,即密码


%% 加密算法
%置乱,利用Arnold矩阵对图像A置乱

A=P_R(:); %将图像分量P_R分量转化成一维向量A
for i=1:M*N
   q=mod(b(i)+a(i)*i,M*N)+1;      % q是变换后的坐标

   A_i=A(i);
   A(i)=A(q);
   A(q)=A_i;
end
A=reshape(A,M,N);   %密文A


%%正向扩散,基于异或运算的扩散处理
A=A(:);             %将图像矩阵转为一维向量A
B0=0;               %正向扩散密钥
B=zeros(1,M*N);     %正向扩散结果
B(1)=bitxor(bitxor(B0,S1(1)),A(1));
for i=2:M*N
   B(i)=bitxor(bitxor(B(i-1),S1(i)),A(i));
end

%逆向扩散
C0=0;               %逆向扩散密钥
C=zeros(1,M*N);     %逆向扩散结果
C(M*N)=bitxor(bitxor(C0,S2(M*N)),B(M*N));
for i=M*N-1:-1:1
   C(i)=bitxor(bitxor(C(i+1),S2(i)),B(i)); 
end
C_R=reshape(C,M,N);   %密文图像分量C_R


A=P_G(:); %将分量P_G转化成一维向量A
for i=1:M*N
   q=mod(b(i)+a(i)*i,M*N)+1;      % q是变换后的坐标

   A_i=A(i);
   A(i)=A(q);
   A(q)=A_i;
end
A=reshape(A,M,N);   %密文A


%正向扩散,基于异或运算的扩散处理
A=A(:);             %将图像矩阵转为一维向量A

B0=0;               %正向扩散密钥
B=zeros(1,M*N);     %正向扩散结果
B(1)=bitxor(bitxor(B0,S1(1)),A(1));
for i=2:M*N
   B(i)=bitxor(bitxor(B(i-1),S1(i)),A(i));
end

%逆向扩散
C0=0;               %逆向扩散密钥
C=zeros(1,M*N);     %逆向扩散结果
C(M*N)=bitxor(bitxor(C0,S2(M*N)),B(M*N));
for i=M*N-1:-1:1
   C(i)=bitxor(bitxor(C(i+1),S2(i)),B(i)); 
end
C_G=reshape(C,M,N);   %密文图像分量C_G


A=P_B(:); %将图像分量P_B转化成一维向量A
for i=1:M*N
   q=mod(b(i)+a(i)*i,M*N)+1;      % q是变换后的坐标

   A_i=A(i);
   A(i)=A(q);
   A(q)=A_i;
end
A=reshape(A,M,N);   %密文A


%扩散,基于异或运算的扩散处理
A=A(:);             %将图像矩阵转为一维向量A

B0=0;               %正向扩散密钥
B=zeros(1,M*N);     %正向扩散结果
B(1)=bitxor(bitxor(B0,S1(1)),A(1));
for i=2:M*N
   B(i)=bitxor(bitxor(B(i-1),S1(i)),A(i));
end

%逆向扩散
C0=0;               %逆向扩散密钥
C=zeros(1,M*N);     %逆向扩散结果
C(M*N)=bitxor(bitxor(C0,S2(M*N)),B(M*N));
for i=M*N-1:-1:1
   C(i)=bitxor(bitxor(C(i+1),S2(i)),B(i)); 
end
C_B=reshape(C,M,N);   %密文图像分量C_B
