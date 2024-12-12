
function [Kc,Kcreg,KcCorr] =ZeroOneTest(dataSet,cont)

%函数功能：完成0-1测试

%输入参数说明

%dataSet:待测试序列

%cont:规定常数值,范围0-pi自选

%------------------------

%输出参数说明

%Kc：利用Mc计算

%Kcreg：利用修正D得到

%------------------------

%测试样例

dataSet = chaotic(960,0.98,67.8, 0.346);

cont = 2 ;

% [Kc,Kcreg,KcCorr] = ZeroOneTest(dataSet,cont);

%参考文献：The 0-1 Testfor Chaos: A Review

%计算开始

Ndata = size(dataSet,1);

p(1)=dataSet(1)*cos(cont);

s(1)=dataSet(1)*sin(cont);

for n = 1:Ndata

       
p(n+1)=p(n)+dataSet(n)*cos(n*cont);

       
s(n+1)=s(n)+dataSet(n)*sin(n*cont);

end

% %画出p和s的轨迹图

% figure

% plot(p,s);

% xlabel('p_c');ylabel('q_c');

% %画图结束；

%计算均方位移

Numn = Ndata/10;%建议不超过数据集大小的十分十一

meanpower = mean(dataSet,1).^2;

for n = 1:Numn

sumMean = 0;

for j = 1:Ndata-Numn%此处公式中N的大小取剩余的值

   
sumMean = sumMean + (p(j+n)-p(j))^2 + (s(j+n)-s(j))^2;

end

Mc(n) = 1/Ndata*sumMean;

Vosc(n) = meanpower*((1-cos(n*cont))/(1-cos(cont)));

end

D = Mc(n) - Vosc(n);

x = 1:Numn;

KcCorr = corr(x',D');

% %画图：画出Mc和D的变化

 figure

 n = 1:Numn;

 plot(n,Mc);

 hold on

plot(n,D);

 xlabel('n');ylabel('Mc,D');

% %结束画图

Dreg = D(Numn) + 1.1*min(abs(D)); 

Kc = log(Mc(Numn))/log(Numn);

Kcreg = log(Dreg)/log(Numn);

end

