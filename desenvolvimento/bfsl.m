blfunction [lines] = bfsl(L)
    dims = size(L);
    len = dimension_length(L);
    invert = false;
    
    for i=1:dims(3)
        invert = false;
        [bfit, gof] = fit(L(1:len(i),1,i),L(1:len(i),2,i),'poly1','Robust','Bisquare');
        if(gof.rsquare < 0 || gof.sse > 0.003)
            [bfitInv, gofInv] = fit(L(1:len(i),2,i),L(1:len(i),1,i),'poly1','Robust','Bisquare');
            if(gofInv.sse < gof.sse && gofInv.rsquare > 0)
                invert = true;
            end
        end
        
        if invert
            Yq = L(1,2,i);
            Yr = L(len(i),2,i);
            Xq = bfitInv.p1*Yq + bfitInv.p2;
            Xr = bfitInv.p1*Yr + bfitInv.p2;
        else
            Xq = L(1,1,i);
            Xr = L(len(i),1,i);
            Yq = bfit.p1*Yq + bfit.p2;
            Yr = bfit.p1*Yr + bfit.p2;
        end
        
        lines(1:2,1:2,i) = [Xq Yq; Xr Yr];
    end
end