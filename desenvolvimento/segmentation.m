function [S C H] = segmentation(P, d)
%   Tests have shown that the an acceptable d is 0.0555
%   Each cluster S, C and H

%   Variable initialization part
    i = 1;
%   The sufix l and d represent, respectively, line and dimension of the
%   clusters
    jl = 1;
    jd = 2;
    
    kl = 1;
    kd = 1;
    
    ml = 1;
    md = 1;
    
    C(1,1:2,1) = P(1,1:2);
    H = [];
    S = [];
    
    while i < (length(P)-1)
        if pdist([P(i+1,1:2);P(i,1:2)]) < d
            H(ml,1:2,md) = P(i+1, 1:2);
            i = i+1;
            ml = ml+1;
        elseif pdist([P(i+2,1:2);P(i,1:2)]) < d
            H(ml,1:2,md) = P(i+2,1:2);
            C(jl,1:2,jd) = P(i+1,1:2);
            ml = ml+1;
            jd = j+1;
            jd = 1;
            i = i+1;
        elseif pdist([P(i+2,1:2);P(i+1,1:2)]) < d       
            md = md+1;
            ml = 1;
            H(ml:(ml+1),1:2,md) = P((i+1):(i+2), 1:2);
            ml = ml+2;
            i = i+2;
        else
            C(jl,1:2,jd) = P(i+1,1:2);
            jd=jd+1;
            jl = 1;
            md = md+1;
            ml = 1;
            H(ml,1:2,md) = P(i+2,1:2);
            ml = ml+1;
            i = i+2;
        end
    end
        
    lenH = dimension_length(H);

    dimsH = size(H);
    dimsC = size(C);

    if(md > 1) 
        md = dimsH(3);
    end

    if(jd > 2)
        jd = dimsC(3) + 1;
    else
        jd = 2;
    end
    
    while md > 0
        lenC = dimension_length(C);
        if lenH(md) <= max(lenC)
            C(1:lenH(md),1:2,jd) = H(1:lenH(md),1:2,md);
            jd = jd+1;
            md = md-1;
        else
            S(1:lenH(md),1:2,kd) = H(1:lenH(md),1:2, md);
            kd = kd+1;
            md = md-1;
        end
    end
end