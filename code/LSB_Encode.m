%% LSB算法实现嵌入图片水印
function CarrierImg = LSB_Encode1(CarrierImg,BinImg,M,N,m,n)
% CarrierImg为载体图像 ，BinImg为二值化后的要隐藏的水印图像
% M为载体图像的行,N为载体图像的列,m为水印图像的行，n为水印图像的列
% bitget(CarrierImg(i,j),1)获取图像CarrierImg中一个像素点的亮度值
% 将该亮度值用二进制表示，bitget(CarrierImg(i,j),1)中的1表示获取最低位的值
% 注意！！！水印图像的m*n 要小于等于载体图像的 M*N
% 即m<=M,n<=N

for i = 1:m
    for j = 1:n
             
               if bitget(BinImg(i,j),1) == 0 && bitget(CarrierImg(i+m,j),1) ==1
                CarrierImg(i+m,j) = CarrierImg(i+m,j)-1;
                elseif bitget(BinImg(i,j),1) == 1 && bitget(CarrierImg(i+m,j),1) ==0
                CarrierImg(i+m,j) = CarrierImg(i+m,j)+1;
                end
                if bitget(BinImg(i,j),2) == 1 && bitget(CarrierImg(i+m,j),2) ==0
                CarrierImg(i+m,j) = CarrierImg(i+m,j)+2;
                elseif bitget(BinImg(i,j),2) == 0 && bitget(CarrierImg(i+m,j),2) ==1
                CarrierImg(i+m,j) = CarrierImg(i+m,j)-2;
                end
                
                if bitget(BinImg(i,j),3) == 0 && bitget(CarrierImg(i,j+m),1) ==1
                CarrierImg(i,j+m) = CarrierImg(i,j+m)-1;
                elseif bitget(BinImg(i,j),3) == 1 && bitget(CarrierImg(i,j+m),1) ==0
                CarrierImg(i,j+m) = CarrierImg(i,j+m)+1;
                end
                if bitget(BinImg(i,j),4) == 1 && bitget(CarrierImg(i,j+m),2) ==0
                CarrierImg(i,j+m) = CarrierImg(i,j+m)+2;
                elseif bitget(BinImg(i,j),4) == 0 && bitget(CarrierImg(i,j+m),2) ==1
                CarrierImg(i,j+m) = CarrierImg(i,j+m)-2;
                end
                
                if bitget(BinImg(i,j),5) == 0 && bitget(CarrierImg(i+m,j+m),1) ==1
                CarrierImg(i+m,j+m) = CarrierImg(i+m,j+m)-1;
                elseif bitget(BinImg(i,j),5) == 1 && bitget(CarrierImg(i+m,j+m),1) ==0
                CarrierImg(i+m,j+m) = CarrierImg(i+m,j+m)+1;
                end
                if bitget(BinImg(i,j),6) == 1 && bitget(CarrierImg(i+m,j+m),2) ==0
                CarrierImg(i+m,j+m) = CarrierImg(i+m,j+m)+2;
                elseif bitget(BinImg(i,j),6) == 0 && bitget(CarrierImg(i+m,j+m),2) ==1
                CarrierImg(i+m,j+m) = CarrierImg(i+m,j+m)-2;
                end
                
                
                 if bitget(BinImg(i,j),7) == 0 && bitget(CarrierImg(i,j),1) ==1
                  CarrierImg(i,j) = CarrierImg(i,j)-1;
                  elseif bitget(BinImg(i,j),7) == 1 && bitget(CarrierImg(i,j),1) ==0
                  CarrierImg(i,j) = CarrierImg(i,j)+1;
                  end
                
                  if bitget(BinImg(i,j),8)  == 1 && bitget(CarrierImg(i,j),2) ==0
                  CarrierImg(i,j) = CarrierImg(i,j)+2;
                 elseif bitget(BinImg(i,j),8) == 0 && bitget(CarrierImg(i,j),2) ==1
                  CarrierImg(i,j) = CarrierImg(i,j)-2;
                 end
                  
                
            
   end
end
  
   