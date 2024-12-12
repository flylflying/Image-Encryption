function result=randlsbimgget(output,mm,nn,key)
ste_cover=imread(output);
ste_cover=double(ste_cover);
[m,n]=size(ste_cover);
%frr=fopen(goalfile,'a');
len_total=mm*nn;
p=1;
[row,col]=randinterval(ste_cover,len_total,key);
for i=1:len_total
    if bitand(ste_cover(row(i),col(i)),1)==1

        result(p,1)=1;
    else

        result(p,1)=0;
    end
    if p==len_total
        break;
    end
    p=p+1;
end
r=1;
for i=1:mm
    for j=1:nn
        byctx(i,j)=result(r);
        r=r+1;
    end
end
imwrite(byctx,'exact.bmp');
figure;
imshow(uint8(byctx));title('提取图像');

          