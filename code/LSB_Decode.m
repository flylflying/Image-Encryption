%% ��ȡLSB�㷨Ƕ���ˮӡ
function OutputImage = LSB_Decode1(InputImage,m,n)
% InputImageΪ����ˮӡ��ͼ�� ��mΪҪ��ȡˮӡ���У�nΪҪ��ȡˮӡ����
% zeros(m,n)����һ��m*n��ȫ0����
% bitget(InputImage(i,j),1)��ȡͼ��InputImage��һ�����ص������ֵ
% ��������ֵ�ö����Ʊ�ʾ��bitget(InputImage(i,j),1)�е�1��ʾ��ȡ���λ��ֵ
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
             
             if bitget(InputImage(i,j),1) == 1
                OutputImage(i,j) = OutputImage(i,j)+64; 
            end
             if bitget(InputImage(i,j),2) == 1
                OutputImage(i,j) = OutputImage(i,j)+128; 
             end
 
      
 

           
    end
end 

