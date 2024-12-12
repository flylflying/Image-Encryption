clear
clc
close all
%分岔图
%离散系统
%% 2 Henon系统
a=0:0.0016:1.4;
%采用直接截取迭代中间过程，作为分岔图
NT=300;%选取最后300次结果
Na=length(a);
BF_x=zeros(Na,NT);
BF_y=zeros(Na,NT);

for k=1:Na
    a_k=a(k);
    %初始值取0
    x1=0;
    y1=0;
    %先初始迭代200次，避免初始值选取引起的干扰
    for m=1:200
%         [x1,y1]=chaotic(x1,y1,a_k,0.3);
        [x1,y1]=chaotic(100,0.98,a_k,0.3);
    end
    %然后再迭代300次，作为要保存的结果
    for m=1:NT
        [x1,y1]=chaotic(x1,y1,a_k,0.3);
        %把结果保存
        BF_x(k,m)=x1;
        BF_y(k,m)=y1;
    end
end

%分岔图1，用y绘图
figure()
hold on
for k=1:Na
    a_k=a(k);
    plot(a_k*ones(1,NT),BF_y(k,1:NT),...
        'LineStyle','none','Marker','.','MarkerFaceColor','k','MarkerEdgeColor','k',...
        'MarkerSize',1)
end
hold off
xlabel('a')
ylabel('y')
%分岔图2，用x绘图
figure()
hold on
for k=1:Na
    a_k=a(k);
    plot(a_k*ones(1,NT),BF_x(k,1:NT),...
        'LineStyle','none','Marker','.','MarkerFaceColor','k','MarkerEdgeColor','k',...
        'MarkerSize',1)
end
hold off
xlabel('a')
ylabel('x')
ylim([-1.5,2])
%绘制典型情况的最终x-y图
figure()
aa=[0.2,0.95,1.036,1.076,1.08,1.38];%要展示的aa图
for k=1:6
    subplot(2,3,k)
    [~,Ind_a]=min(abs(a-aa(k)));
    plot(BF_x(Ind_a,:),BF_y(Ind_a,:),'LineStyle','none','Marker','.')
    xlim([-1.5,1.5])
    ylim([-0.4,0.4])
    xlabel('x');ylabel('y');
    title(['a=',num2str(aa(k))])
end

%% 后置函数
function [x2,y2]=Henon(x1,y1,a,b)
%Henon系统
%x(n+1)=1+y(n)-a*x(n)^2
%y(n+1)=b*x(n)
x2=1+y1-a*x1.*x1;
y2=b*x1;
end
