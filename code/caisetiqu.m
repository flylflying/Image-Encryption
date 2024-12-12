size=512;%图像大小：256*256
block=2;%块大小：8*8
%决定了水印图片不大于32*32
blockno=size/block;%每行块的个数32
ratio=0.02;
out_object1=zeros(256,256);
out_object2=zeros(256,256);
out_object3=zeros(256,256);
unw_object=imread('bardowl(1).jpg');
w_object=imread('watered.bmp');
mark=imread('lena.bmp');%彩色水印图

for m=1:blockno;
    for n=1:blockno;
        x=(m-1)*block+1;
        y=(n-1)*block+1;
        unw1_dct=unw_object(x:x+block-1,y:y+block-1,1);
        unw1_dct=dct2(unw1_dct);

        unw2_dct=unw_object(x:x+block-1,y:y+block-1,2);
        unw2_dct=dct2(unw2_dct);

        unw3_dct=unw_object(x:x+block-1,y:y+block-1,3);
        unw3_dct=dct2(unw3_dct);
        
        w1_dct=w_object(x:x+block-1,y:y+block-1,1);
        w1_dct=dct2(w1_dct);

        w2_dct=w_object(x:x+block-1,y:y+block-1,2);
        w2_dct=dct2(w2_dct);      
        
        w3_dct=w_object(x:x+block-1,y:y+block-1,3);
        w3_dct=dct2(w3_dct);        
        
        out_object1(m,n)=(w1_dct(1,1)-unw1_dct(1,1))/ratio;
        out_object2(m,n)=(w2_dct(1,1)-unw2_dct(1,1))/ratio;
        out_object3(m,n)=(w3_dct(1,1)-unw3_dct(1,1))/ratio;
    end;
end;
disp(out_object1);
out_object1=idct2(out_object1);
out_object2=idct2(out_object2);
out_object3=idct2(out_object3);

out_object1_u=uint8(out_object1);
out_object2_u=uint8(out_object2);
out_object3_u=uint8(out_object3);

out_object(:,:,1)=out_object1_u;
out_object(:,:,2)=out_object2_u; 
out_object(:,:,3)=out_object3_u; 

figure(2);
subplot(2,2,1);
imshow(unw_object);title('原始图像');
subplot(2,2,2);
imshow(w_object);title('嵌入水印的图像');
subplot(2,2,3);
imshow(out_object);title('提取水印图像');
subplot(2,2,4);
imshow(mark);title('水印图像');
