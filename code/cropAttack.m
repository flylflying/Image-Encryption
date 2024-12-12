%% Crop Attack
function watermarked_image = cropAttack(watermarked_image)
N = 512;
cc = 128; %这里令中间的白色正方形大小为32*32
 watermarked_image((N-cc)/2:(N+cc)/2,(N-cc)/2:(N+cc)/2)=0; %将中间变成白色，即赋值为255
% watermarked_image((0:16,N-16,)=0;
end
