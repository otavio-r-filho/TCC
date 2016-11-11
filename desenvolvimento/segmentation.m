function [S C H] = segmentation(P, d)
%   Tests have shown that the an acceptable d is 0.0555
%   Each cluster S, C and H

%   Variable initialization part
    i = 1;
    j = 2;
    k = 1;
    
%  ml e md represent, respectively, line and dimension of the auxiliary
%  cluster H
    ml = 1;
    md = 1;
    
    C(1,1:2) = P(1,1:2);
    H = [];
    S = [];
    
    while i < (length(P)-1)
        if pdist([P(i+1,1:2);P(i,1:2)]) < d
            H(ml,1:2,md) = P(i+1, 1:2);
            i = i+1;
            ml = ml+1;
        elseif pdist([P(i+2,1:2);P(i,1:2)]) < d
            H(ml,1:2,md) = P(i+2, 1:2);
            C(j,1:2) = P(i,1:2);
            ml = ml+1;
            j = j+1;
            i = i+1;
        elseif pdist([P(i+2,1:2);P(i+1,1:2)]) < d       
            md = md+1;
            ml = 1;
            H(ml:(ml+1),1:2,md) = P((i+1):(i+2), 1:2);
            ml = ml+2;
            i = i+2;
        else
            C(j,1:2) = P(i+1,1:2);
            j=j+1;
            md = md+1;
            ml = 1;
            H(ml,1:2,md) = P(i+2,1:2);
            ml = ml+1;
            i = i+2;
        end
    end
end