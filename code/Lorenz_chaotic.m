function X = Lorenz_chaotic(delta,n)
%% 生成超Lorenz混沌序列，n为序列长度
    h = 0.002;                                                                                                                        % h为步长
    t = 1000;                                                                                                                         % t为过渡态长度
    a = 10; b = 8/3; c = 28; r = -1;
    x0 = 1.13; y0 = 2.52; z0 = 3.38; w0 = 4.64+delta;                                                                                 % 赋初值，范围分别为（-40，40）、（-40，40）、（1，81），（-250，250）
    s = zeros(1,n);
    for i = 1 : n+t
        k11 = a*(y0-x0)+w0;k12=a*(y0-(x0+k11*h/2))+w0;
        k13 = a*(y0-(x0+k12*h/2))+w0;k14=a*(y0-(x0+k13*h))+w0;
        x1 = x0+(k11+k12+k13+k14)*h/6;

        k21 = c*x1-y0-x1*z0;
        k22 = c*x1-(y0+k21*h/2)-x1*z0;
        k23 = c*x1-(y0+k22*h/2)-x1*z0;
        k24 = c*x1-(y0+k23*h)-x1*z0;
        y1 = y0+(k21+k22+k23+k24)*h/6;

        k31 = x1*y1-b*z0;
        k32 = x1*y1-b*(z0+k31*h/2);
        k33 = x1*y1-b*(z0+k32*h/2);
        k34 = x1*y1-b*(z0+k33*h);
        z1 = z0+(k31+k32+k33+k34)*h/6;

        k41 = -y1*z1+r*w0; 
        k42 = -y1*z1+r*(w0+k41*h/2);
        k43 = -y1*z1+r*(w0+k42*h/2);
        k44 = -y1*z1+r*(w0+k43*h);
        w1 = w0+(k41+k42+k43+k44)*h/6;

        x0 = x1; y0 = y1; z0 = z1; w0 = w1;
        if i > t
            s(i-t) = x1;
            if mod((i-t), 3000) == 0
                x0 = x0+h*sin(y0);
            end
        end
    end
    X = mod(floor((s+100)*10^10),n)+1;
    [~,idx] = unique(X); 
    X1 = zeros(1,n);
    X1(1:length(idx)) = X(sort(idx));
    X1(length(idx)+1:n) = setdiff(1:n,X1);
    X = X1;
end


    