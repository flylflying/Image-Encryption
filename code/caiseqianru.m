clear;
size=512;%ͼ���С��256*256
block=2;%���С��8*8
%������ˮӡͼƬ������32*32
blockno=size/block;%ÿ�п�ĸ���32
ratio=0.1;
mark=imread('lena.bmp');%��ɫˮӡͼ
subplot(2,2,1);
imshow(mark);title('ˮӡͼ��');
object=imread('bardowl(1).jpg');%�����ɫͼ��
subplot(2,2,2);imshow(object);title('ԭʼͼ��');
mark1=mark(:,:,1);%R
mark2=mark(:,:,2);%G
mark3=mark(:,:,3);%B

%Ƕ��ˮӡ
mark1_dct=dct2(mark1);
mark2_dct=dct2(mark2);
mark3_dct=dct2(mark3);
%disp(object);
for m=1:blockno;
    for n=1:blockno;
        x=(m-1)*block+1;
        y=(n-1)*block+1;
        %��һά
        block_dct1=object(x:x+block-1,y:y+block-1,1);%ȡ�ÿ���������
        block_dct1=dct2(block_dct1);%�任
        %�ڶ�ά
        block_dct2=object(x:x+block-1,y:y+block-1,2);%ȡ�ÿ���������
        block_dct2=dct2(block_dct2);%�任
        %����ά
        block_dct3=object(x:x+block-1,y:y+block-1,3);%ȡ�ÿ���������
        block_dct3=dct2(block_dct3);%�任
        
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
imshow(object);title('Ƕ��ˮӡ���ͼ��');
imwrite(object,'watered.bmp'); 
s=object(:,:,1);%R
s_dct=s(1:8,1:8,1);
s_dct=dct2(s_dct);
 disp(s_dct);
