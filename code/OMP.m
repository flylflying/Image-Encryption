function theta = OMP(y,A,t)  
% CS_OMP Summary of this function goes here  
%   Detailed explanation goes here  
%   y = Phi * x  
%   x = Psi * theta  
%   y = Phi*Psi * theta  
%   �� A = Phi*Psi, ��y=A*theta  
%   ������֪y��A����theta  
    [y_rows,y_columns] = size(y);  
    if y_rows < y_columns  
        y = y';                                                                                                                   % y should be a column vector  
    end  
    [M,N] = size(A);                                                                                                              % ���о���AΪM*N����  
    theta = zeros(N,1);                                                                                                           % �����洢�ָ���theta(������)  
    At = zeros(M,t);                                                                                                              % �������������д洢A��ѡ�����  
    Pos_theta = zeros(1,t);                                                                                                       % �������������д洢A��ѡ��������  
    r_n = y;                                                                                                                      % ��ʼ���в�(residual)Ϊy  
    for ii = 1 : t                                                                                                                % ����t�Σ�tΪ�������  
        product = A'*r_n;                                                                                                         % ���о���A������в���ڻ�  
        [~,pos] = max(abs(product));                                                                                              % �ҵ�����ڻ�����ֵ������в�����ص���  
        At(:,ii) = A(:,pos);                                                                                                      % �洢��һ��  
        Pos_theta(ii) = pos;                                                                                                      % �洢��һ�е����  
        A(:,pos) = zeros(M,1);                                                                                                    % ����A����һ�У���ʵ���п��Բ�Ҫ����Ϊ����в�����  
        theta_ls = (At(:,1:ii)'*At(:,1:ii))^(-1)*At(:,1:ii)'*y;                                                                   % ��С���˽�  
        r_n = y - At(:,1:ii)*theta_ls;                                                                                            % ���²в� 
    end
    theta(Pos_theta) = theta_ls;                                                                                                  % �ָ�����theta  
end