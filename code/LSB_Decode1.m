%% 提取LSB算法嵌入的水印
function OutputImage = LSB_Decode1(InputImage,m,n)
% InputImage为含有水印的图像 ，m为要提取水印的行，n为要提取水印的列
% zeros(m,n)生成一个m*n的全0矩阵
% bitget(InputImage(i,j),1)获取图像InputImage中一个像素点的亮度值
% 将该亮度值用二进制表示，bitget(InputImage(i,j),1)中的1表示获取最低位的值
OutputImage = zeros(m,n);

for i = 1:m
    for j = 1:n
        
          
             if bitget(InputImage(i+m,j),1) == 1
                OutputImage(i,j) = OutputImage(i,j)+1; 
             end
             if bitget(InputImage(i+m,j),2) == 1
                OutputImage(i,j) = OutputImage(i,j)+2;                
            end



             if bitget(InputImage(i,j+m),1) == 1
                OutputImage(i,j) = OutputImage(i,j)+4; 
             end
             if bitget(InputImage(i,j+m),2) == 1
                OutputImage(i,j) = OutputImage(i,j)+8; 
             end
 


            if bitget(InputImage(i+m,j+m),1) == 1
                OutputImage(i,j) = OutputImage(i,j)+16; 
            end
             if bitget(InputImage(i+m,j+m),2) == 1
                OutputImage(i,j) = OutputImage(i,j)+32; 
             end
             
             if bitget(InputImage(i+m,j+m),3) == 1
                OutputImage(i,j) = OutputImage(i,j)+64; 
            end
             if bitget(InputImage(i+m,j+m),4) == 1
                OutputImage(i,j) = OutputImage(i,j)+128; 
             end
 

           
    end
end 

