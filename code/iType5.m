function A = iType5(s)
% »¹Ô­
m = numel(s)/2;
n = sqrt(2*m);
s = reshape(s,2,m);
s = [s(1,:) s(2,:)];
K = [1:n n-1:-1:1];
cur = 1;
A = zeros(n,n);
for i = 1:numel(K)
    temp = s(cur:sum(K(1:i)));
    cur = sum(K(1:i))+1;
    if mod(i,2)~=0
        temp = fliplr(temp);
    end
    
    if i <= n
        index0 = 1;
        index1 = n-i+1;
    else
        index0 = i-n+1;
        index1 = 1;
    end

    A(index0,index1) = temp(1);
    j = 1;
    while index0+j<=n && index1+j<=n
        A(index0+j,index1+j) = temp(j+1);
        j = j+1;
    end
end
A = reshape(A, n, n);
end