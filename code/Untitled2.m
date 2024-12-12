clear all
r = 5;
for a=0.01:0.01:4
    i=round(a*100);
    X = chaotic(1000,a,67.8,0.346);
    c(i) = SampEn(X);
end
a=0.01:0.01:4;
figure(1);
plot(a,c)
xlabel('a','fontsize',12,'FontAngle','italic');
ylabel('SE','fontsize',12,'FontAngle','italic');


for a=0.01:0.01:4
    i=round(a*100);
    X = chaotic(1000,a,67.8,0.346);
    c1(i) = C_zero(r,X);
end
a=0.01:0.01:4;
figure(2);
plot(a,c1)
xlabel('a','fontsize',12,'FontAngle','italic');
ylabel('C0','fontsize',12,'FontAngle','italic');

% for a=0.01:0.01:4
%     i=round(a*100);
%     X = chaotic(3000,a,67.8,0.346);
%     c2(i) = X;
% end
% a=0.01:0.01:4;
% figure(2);
% plot(a,c2)
% xlabel('a','fontsize',12,'FontAngle','italic');
% ylabel('y','fontsize',12,'FontAngle','italic');