function imgPrem = Fantrans(img1)
    [row, col] = size(img1);
    t00 = 9;  t01 = 5;  t10 = 11;  t11 = 6;
    K = max([abs(t00), abs(t01), abs(t10), abs(t11)]);
    imgPrem = img1;
    for i = 1 : 1 : row
        for j = 1 : 1 : col
            p = mod(([t00, t01; t10, t11]*[i; j] + K*[row; col]), [row; col]) + [1; 1];
            t = imgPrem(i, j);
            imgPrem(i, j) = imgPrem(p(1), p(2));
            imgPrem(p(1), p(2)) = t;
        end
    end
end

