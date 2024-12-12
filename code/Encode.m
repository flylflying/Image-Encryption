function [A, B, C] = Encode(X, Y, Z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scramble the martrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   X, Y, Z:(with the same size n*n)
% ouput:
%   A, B, C:(with the same size n*n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(X, 1);

A = zeros(n,n);
B = zeros(n,n);
C = zeros(n,n);

temp = [];
for i = 1:n
    if i == 1   % the first corner of the cube
        % lower right corner
        temp_X = X(n,n);
        % top right corner
        temp_Y = Y(1,n);
        % top left corner
        temp_Z = Z(1,1);
    else
        % lower right corner
        temp_X = [X(n-i+1, n:-1:n-i+1), X(n-i+2:n, n-i+1)'];
        % top right corner
        temp_Y = [Y(1:i-1, n-i+1)', Y(i, n-i+1:end)];
        % top left corner
        temp_Z = [Z(i, 1:i), Z(i-1:-1:1, i)'];
    end
    temp = [temp, temp_X, temp_Y, temp_Z];
end

A = reshape(temp(1 : n^2), n, n)';
B = reshape(temp(n^2+1 : 2*n^2), n, n)';
C = reshape(temp(2*n^2+1 : end), n, n)';

end