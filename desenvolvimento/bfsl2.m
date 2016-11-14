function [c, R2] = bfsl2(x,y)
    %len = dimension_length(L);
    % Make sure that x and y are column vectors
    %x = L(1:len(1),1,1); 
    %y = L(1:len(1),2,1); 
    
    % m-by-n matrix of overdetermined system
    A = [x ones(size(x))];
    % Solve normal equations
    c = (A'*A)\(A'*y);
    
    if nargout>1
        r = y - A*c;
        R2 = 1 - (norm(r)/norm(y-mean(y)))^2;
    end
    
end
