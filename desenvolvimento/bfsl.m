function [lines, plotlines] = bfsl(L)
    dims = size(L);
    len = dimension_length(L);
    j=1;
    for i=1:dims(3)
        [bfit gof output] = fit(L(1:len(i),1,i),L(1:len(i),2,i),'poly1','Robust','Bisquare');
        if(gof.rsquare < 0 || gof.sse > 50)
            [bfit gof output] = fit(L(1:len(i),2,i),L(1:len(i),1,i),'poly1','Robust','Bisquare');
            Yq = L(1,2,i);
            Yr = L(len(i),2,i);
            Xq = bfit.p1*Yq + bfit.p2;
            Xr = bfit.p1*Yr + bfit.p2;
        else
            Xq = L(1,1,i);
            Xr = L(len(i),1,i);
            Yq = bfit.p1*Yq + bfit.p2;
            Yr = bfit.p1*Yr + bfit.p2;
        end
        lines(1:2,1:2,i) = [Xq Yq; Xr Yr];
        plotlines(j:j+1,1:2) = [Xq Yq; Xr Yr];
        j = j+1;
    end
end