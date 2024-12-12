clear;
size=512;%图像大小：256*256
block=2;%块大小：8*8
%决定了水印图片不大于32*32
blockno=size/block;%每行块的个数32
ratio=0.1;
mark=imread('lena.bmp');%彩色水印图
subplot(2,2,1);
imshow(mark);title('水印图像');
object=imread('bardowl(1).jpg');%读入彩色图像
subplot(2,2,2);imshow(object);title('原始图像');
mark1=mark(:,:,1);%R
mark2=mark(:,:,2);%G
mark3=mark(:,:,3);%B

%嵌入水印
mark1_dct=dct2(mark1);
mark2_dct=dct2(mark2);
mark3_dct=dct2(mark3);
%disp(object);
for m=1:blockno;
    for n=1:blockno;
        x=(m-1)*block+1;
        y=(n-1)*block+1;
        %第一维
        block_dct1=object(x:x+block-1,y:y+block-1,1);%取该块所有像素
        block_dct1=dct2(block_dct1);%变换
        %第二维
        block_dct2=object(x:x+block-1,y:y+block-1,2);%取该块所有像素
        block_dct2=dct2(block_dct2);%变换
        %第三维
        block_dct3=object(x:x+block-1,y:y+block-1,3);%取该块所有像素
        block_dct3=dct2(block_dct3);%变换
        
        block_dct1(1,1)=block_dct1(1,1)+ratio*mark1_dct(m,n);
        block_dct2(1,1)=block_dct2(1,1)+ratio*mark2_dct(m,n);
        block_dct3(1,1)=block_dct3(1,1)+ratio*mark3_dct(m,n);
    
        block_dct1=idct2(block_dct1);
        block_dct2=idct2(block_dct2);
        block_dct3=idct2(block_dct3);
        object(x:x+block-1,y:y+block-1,1)=block_dct1;
        object(x:x+block-1,y:y+block-1,2)=block_dct2;
        object(x:x+block-1,y:y+block-1,3)=block_dct3;
    end;
end;
%disp(object);
subplot(2,2,4);
imshow(object);title('嵌入水印后的图像');
imwrite(object,'watered.bmp'); 
s=object(:,:,1);%R
s_dct=s(1:8,1:8,1);
s_dct=dct2(s_dct);
 disp(s_dct);
