function[ste_cover,len_total]=randlsbimghide(input,output,key)
cover=imread(input);
ste_cover=cover;
ste_cover=double(ste_cover);
%f_id=fopen(file,'r');
%[msg,len_total]=fread(f_id,'ubit1');
msgg=imread('baboo256.bmp');
[mm,nn]=size(msgg);
len_total=mm*nn;
r=1;
for i=1:mm
    for j=1:nn
        msg(r)=msgg(i,j);
        r=r+1;
    end
end
[m,n]=size(ste_cover);
if len_total > m*n
    error('嵌入消息量过大');
end
p=1;
[row,col]=randinterval(ste_cover,len_total,key);
for i=1:len_total

            ste_cover(row(i),col(i))=ste_cover(row(i),col(i))-mod(ste_cover(row(i),col(i)),2)+msg(p);


        if p==len_total
            break;
        end
        p=p+1;
end

ste_cover=uint8(ste_cover);
imwrite(ste_cover,'output.bmp');
subplot(121);imshow(cover);title('原始图像');
subplot(122);imshow(ste_cover);title('隐藏信息的图像');

