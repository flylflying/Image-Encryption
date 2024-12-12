
 function A = chaotic(len,a,cx0,cy0)
%     len = 1000; a = 0.98; cx0 = 67.8; cy0 = 0.346;
    cx = zeros(1,1000+len); cy = zeros(1,1000+len); 
    cx(1) = cx0; cy(1) = cy0; 
    for j = 1 : 1000+len-1
        %cx(j+1) = sin(pi*(cos((4-a)*acos(cx(j)))+sin(a/cy(j))));
        %cy(j+1) = sin(pi*(cos((4-a)*acos(cy(j)))+sin(a/cx(j))));
        A = [400,-201+cx(j);-800+cx(j),401];
        B = [200;-200];   
        x = A\B;
        cx(j+1)=mod(sin(pi*x(1)*(4*a*cx(j)*(1-cx(j)))+(1-a)*sin(pi*cy(j))),1);
        cy(j+1)=mod(sin(pi*x(2)*(4*a*cy(j)*(1-cy(j)))+(1-a)*sin(pi*cx(j).^2)),1); 
    end
    A = (cx(1001:end)+cy(1001:end))/2;
%     plot(cx,cy);
%     xlim([0, 1]);
%     ylim([0, 1]);
%    xlabel('cx');
%    ylabel('cy');
 end