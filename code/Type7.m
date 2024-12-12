function s = Type7(A)
% A: n*n¾ØÕó nÎªÅ¼Êı
n = length(A);
m = numel(A)/2;
s = [];
for i = 1:2*n-1
    if i <= n
        index0 = 1;
        index1 = n-i+1;
    else
        index0 = i-n+1;
        index1 = 1;
    end
    temp = A(index0,index1);
    j = 1;
    while index0+j<=n && index1+j<=n
        temp = [temp A(index0+j,index1+j)];
        j = j+1;
    end
    if mod(i,2)~=0
        temp = fliplr(temp);
    end
    s = [s temp];
    
end
s = [fliplr(s(1:m)); s(m+1:end)];
%s = reshape(s, 1, 2*m);
s = reshape(s, n, n);
end