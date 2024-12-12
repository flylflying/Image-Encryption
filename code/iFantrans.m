function imgiPrem = iFantrans(img1)
    [row, col] = size(img1);
    t00 = 9;  t01 = 5;  t10 = 11;  t11 = 6;
    K = max([abs(t00), abs(t01), abs(t10), abs(t11)]);
    imgiPrem = img1;
    for i = row : -1 : 1
        for j = col : -1 : 1
            p = mod(([t00, t01; t10, t11]*[i; j] + K*[row; col]), [row; col]) + [1; 1];
            t = imgiPrem(i, j);
            imgiPrem(i, j) = imgiPrem(p(1), p(2));
            imgiPrem(p(1), p(2)) = t;
        end
    end
end