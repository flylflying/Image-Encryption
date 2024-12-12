
function phi_s = opmm(psi,phi,mu_G,K1,K2,lamda)
beta = 0;    %约束系数
D = phi*psi;
%外层循环
l = 0;
while l < K1
    % 列单位化
    [m, n] = size(D);
    for i = 1:n
        temp(i) = sqrt(sum(D(:,i).^2));
    end
    D_s = D./temp;
    
    G_s = D_s'*D_s;
    for i = 1:size(G_s,1)
        for j = 1:size(G_s,2)
            if i==j
                G_u(i,j) = 1;
            elseif abs(G_s(i,j))<mu_G
                G_u(i,j) = G_s(i,j);
            else
                G_u(i,j) = mu_G * sign(G_s(i,j));
            end
        end
    end
    
    %内层循环
    f = D*(D'*D-G_u);
    d = -f;     %下降方向
    L = 0;
    while L < K2
        D = D + lamda*d;
        f = D*(D'*D-G_u);
        d = -f + beta*d;
        L = L+1;
    end
    l = l+1;
end

phi_s = D/psi;
%[Q, R] = qr(phi_s');
%for i = length(R)
%    R_s(i,i) = R(i,i);
%end
%temp = Q*R_s;
%phi_s = temp';


