function [X, Y, Z] = Decode(A, B, C)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scramble the martrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   A, B, C:(with the same size n*n)
% ouput:
%   X, Y, Z:(with the same size n*n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(A,1);

temp_A = reshape(A', 1, n^2);
temp_B = reshape(B', 1, n^2);
temp_C = reshape(C', 1, n^2);

temp = [temp_A, temp_B, temp_C];

X = zeros(n,n);
Y = zeros(n,n);
Z = zeros(n,n);

pre = 0;
for i = 1:n
    % calculate the index
    len = 2*i-1;
    index_X = pre+1 : pre+len;
    index_Y = pre+len+1 : pre+2*len;
    index_Z = pre+2*len+1 : pre+3*len;
    pre = 3*len + pre;
    % get the data
    temp_X = temp(index_X);
    temp_Y = temp(index_Y);
    temp_Z = temp(index_Z);
    % fill the intial martrix
    if i == 1   % the first corner of the cube
        % lower right corner
        X(n,n) = temp_X;
        % top right corner
        Y(1,n) = temp_Y;
        % top left corner
        Z(1,1) = temp_Z;
    else
        % lower right corner
        X(n-i+1, n:-1:n-i+1) = temp_X(1:(len+1)/2);
        X(n-i+2:n, n-i+1) = temp_X((len+1)/2+1 : end);
        % top right corner
        Y(1:i-1, n-i+1) = temp_Y(1:(len-1)/2);
        Y(i, n-i+1:end) = temp_Y((len-1)/2+1 : end);
        % top left corner
        Z(i, 1:i) = temp_Z(1:(len+1)/2);
        Z(i-1:-1:1, i) = temp_Z((len+1)/2+1 : end);
    end
end


end