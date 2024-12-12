function A = NewMap(len,a,cx0,cy0)
    cx = zeros(1,1000+len); cy = zeros(1,1000+len); 
    cx(1) = cx0; cy(1) = cy0; 
    for j = 1 : 1000+len-1
        cx(j+1) = sin(pi*(cos((4-a)*acos(cx(j)))+sin(a/cy(j))));
        cy(j+1) = sin(pi*(cos((4-a)*acos(cy(j)))+sin(a/cx(j))));
%         cx(j+1)=sin(pi*(4*a*cx(j)*(1-cx(j)))+(1-a)*sin(pi*cy(j)));
%         cy(j+1)=sin(pi*(4*a*cy(j)*(1-cy(j)))+(1-a)*sin(pi*cx(j).^2)); 
    end
    A = (cx(1001:end)+cy(1001:end))/2;
end

