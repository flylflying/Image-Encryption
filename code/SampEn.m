function SE = SampEn(x) %x为一维数组序列
x = x - mean(x);
X = fft(x);%离散傅里叶变换
N = ceil((size(X,2)/2));
X = X(1:N);%取得变换后序列前半部分
Pk = (abs(X).*abs(X))./sum(abs(X).*abs(X));%计算Pk-相对功率谱概率
j=1;
for i=1:N
    if Pk(i)~=0
        Pk1(j)=Pk(i);
        j = j+1;
    end
end%去除PK中为0的值，避免出现se无穷大
se = -sum(Pk1.*log(Pk1));
SE = se/log(N);%谱熵归一化
end