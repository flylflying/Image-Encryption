function de_scr = descramble_arnold(C,x)
%% 本程序利用Arnold映射实现二维图像像素的置乱，x为输入伪随机序列，将其一分为二，分别是a和b
    [m,n] = size(C);
    d = m*n;
    C = double(C);
    a = reshape(x(1:d),m,n);b=reshape(x(d+1:2*d),m,n);
    B = C;
    for i = m : -1 : 1
        for j = n : -1 : 1
            k = mod([1 a(i,j);b(i,j) a(i,j)*b(i,j)+1]*[i;j],[m;n])+[1;1];
            t = B(i,j);B(i,j)=B(k(1),k(2));B(k(1),k(2))=t;
        end
    end
    de_scr = B;
end