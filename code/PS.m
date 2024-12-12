function [ssim,psnr] = PS(inputimg1,inputimg2)
    img1 = double(inputimg1);
    img2 = double(inputimg2);
    [M,N] = size(img1);
    K = [0.01,0.03];
    L = 255;
    C1 = (K(1)*L)^2;
    C2 = (K(2)*L)^2;
    C3 = C2/2;
    u1 = mean(img1(:));
    u2 = mean(img2(:));
    l = (2*u1*u2+C1)/(u1^2+u2^2+C1);
    d1 = std(img1(:));
    d2 = std(img2(:));
    c = (2*d1*d2+C2)/(d1^2+d2^2+C2);
    d12 = sum(sum((img1-mean(img1(:))).*(img2-mean(img2(:)))))/(M*N-1);
    s = (d12+C3)/(d1*d2+C3);
    ssim = double(l)*double(c)*double(s);
    psnr = 10 * log10(255^2 * M * N / sum(sum((uint8(img1)-uint8(img2)).^2)));
end

