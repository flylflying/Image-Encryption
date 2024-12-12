clc;
clear
d0=1e-7;
Z=[]; 
r=0.5;
for u=linspace(0,8,800)
   le=0;
   lsum=0;
   x=[r;u];
   x1=[r+d0;u];
   for k=1:800
       x=chaotic(100,x,0.64,98);
       x1=chaotic(100,x1,0.64,98);
       d1=sqrt((x(1)-x1(1))^2);%1范数
       x1=x+(d0/d1)*(x1-x);
       if k>100
           lsum=lsum+log(d1/d0);
       end
       x=[x(1);u];
       x1=[x1(1);u];
   end
   le=lsum/(k-100);
   Z=[Z,u+le*1i]; 
end
plot(Z,'-') 
xlabel('k','fontsize',12,'FontAngle','italic');
ylabel('Lyapunov exponent','fontsize',12,'FontAngle','italic');
grid on;