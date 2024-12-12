function [F_R,F_G,F_B]= iEncryDiffusion(C_R,C_G,C_B)
%图像解密处理
%逆向扩散还原
[M,N]=size(C_R);
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

C=C_R(:);
D0=0;
D=zeros(1,M*N);
D(M*N)=bitxor(bitxor(D0,S2(M*N)),C(M*N));
for i=M*N-1:-1:1
    D(i)=bitxor(bitxor(C(i+1),S2(i)),C(i));
end

%正向扩散还原图像
E0=0;
E=zeros(1,M*N);
E(1)=bitxor(bitxor(E0,S1(1)),D(1));
for i=2:M*N
   E(i)=bitxor(bitxor(D(i-1),S1(i)),D(i)); 
end

E=reshape(E,M,N);   %解密明文E

%置乱还原
F=E(:);
for i=M*N:-1:1
   q=mod(b(i)+a(i)*i,M*N)+1;      % q是变换后的坐标

   F_i=F(i);
   F(i)=F(q);
   F(q)=F_i;
end
F_R=reshape(F,M,N);


C=C_G(:);
D0=0;
D=zeros(1,M*N);
D(M*N)=bitxor(bitxor(D0,S2(M*N)),C(M*N));
for i=M*N-1:-1:1
    D(i)=bitxor(bitxor(C(i+1),S2(i)),C(i));
end

%正向扩散还原图像
E0=0;
E=zeros(1,M*N);
E(1)=bitxor(bitxor(E0,S1(1)),D(1));
for i=2:M*N
   E(i)=bitxor(bitxor(D(i-1),S1(i)),D(i)); 
end
E=reshape(E,M,N);   %解密明文E

%置乱还原
F=E(:);
for i=M*N:-1:1
   q=mod(b(i)+a(i)*i,M*N)+1;      % q是变换后的坐标

   F_i=F(i);
   F(i)=F(q);
   F(q)=F_i;
end
F_G=reshape(F,M,N);


C=C_B(:);
D0=0;
D=zeros(1,M*N);
D(M*N)=bitxor(bitxor(D0,S2(M*N)),C(M*N));
for i=M*N-1:-1:1
    D(i)=bitxor(bitxor(C(i+1),S2(i)),C(i));
end

%正向扩散还原图像
E0=0;
E=zeros(1,M*N);
E(1)=bitxor(bitxor(E0,S1(1)),D(1));
for i=2:M*N
   E(i)=bitxor(bitxor(D(i-1),S1(i)),D(i)); 
end
E=reshape(E,M,N);   %解密明文E

%置乱还原
F=E(:);
for i=M*N:-1:1
   q=mod(b(i)+a(i)*i,M*N)+1;      % q是变换后的坐标

   F_i=F(i);
   F(i)=F(q);
   F(q)=F_i;
end
F_B=reshape(F,M,N);
