%�ļ�����liftwavedec2.m
%��  д�����ָ�
%ʱ  �䣺2005/11/01
%�������ܣ�����С��harr�任������С���任
%�����ʽ������imgwave=liftwavedec2(image,256,3)
%����˵����
% image--�����ͼ�����ҪΪ����
% m    --�����ͼ������С
% n    --С���任����
%����������
% img=imread('lena.jpg');
% [m,m]=size(img);
% imgwave=liftwavedec2(img,m,3);
% imshow(imgwave);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function imgwave=liftwavedec2(image,m,n)
img=image;
M=m;
for i=1:n
     imgwave1=lwavedec2(img,M);
     imgwave(1:M,1:M)=imgwave1;
     M=M/2;
     img=imgwave1(1:M,1:M);
end

%
% ����С��harr�任������С���任
%
function f_row=lwavedec2(image,N)
f=image;
T=N/2;               %  ��ͼ��ά��


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.�б任

%  A.���ѣ���ż�ֿ���

f1=f([1:2:N-1],:);  %  ����
f2=f([2:2:N],:);    %  ż��

% f1(:,T+1)=f1(:,1);  %  ����
% f2(T+1,:)=f2(1,:);  %  ����

%  B.Ԥ��

for i_hc=1:T;
    high_frequency_column(i_hc,:)=f1(i_hc,:)-f2(i_hc,:);
end;

% high_frequency_column(T+1,:)=high_frequency_column(1,:);  %  ����

%  C.����

for i_lc=1:T;
    low_frequency_column(i_lc,:)=f2(i_lc,:)+1/2*high_frequency_column(i_lc,:);
end;

%  D.�ϲ�
f_column([1:1:T],:)=low_frequency_column([1:T],:);


f_column([T+1:1:N],:)=high_frequency_column([1:T],:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.�б任

%  A.���ѣ���ż�ֿ���

f1=f_column(:,[1:2:N-1]);  %  ����
f2=f_column(:,[2:2:N]);    %  ż��


% f2(:,T+1)=f2(:,1);    %  ����

%  B.Ԥ��

for i_hr=1:T;
    high_frequency_row(:,i_hr)=f1(:,i_hr)-f2(:,i_hr);
end;

% high_frequency_row(:,T+1)=high_frequency_row(:,1);  %  ����

%  C.����

for i_lr=1:T;
    low_frequency_row(:,i_lr)=f2(:,i_lr)+1/2*high_frequency_row(:,i_lr);
end;

%  D.�ϲ�
f_row(:,[1:1:T])=low_frequency_row(:,[1:T]);

f_row(:,[T+1:1:N])=high_frequency_row(:,[1:T]);















