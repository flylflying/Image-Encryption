%% LSB�㷨ʵ��Ƕ��ͼƬˮӡ
function CarrierImg = LSB_Encode1(CarrierImg,BinImg,M,N,m,n)
% CarrierImgΪ����ͼ�� ��BinImgΪ��ֵ�����Ҫ���ص�ˮӡͼ��
% MΪ����ͼ�����,NΪ����ͼ�����,mΪˮӡͼ����У�nΪˮӡͼ�����
% bitget(CarrierImg(i,j),1)��ȡͼ��CarrierImg��һ�����ص������ֵ
% ��������ֵ�ö����Ʊ�ʾ��bitget(CarrierImg(i,j),1)�е�1��ʾ��ȡ���λ��ֵ
% ע�⣡����ˮӡͼ���m*n ҪС�ڵ�������ͼ��� M*N
% ��m<=M,n<=N

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
  
   