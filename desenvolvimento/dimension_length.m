function count = dimension_length(Arr)
%   This function cumputes the length of the given cluster dimension. It
%   stops when a zero line is found.
%   from num. This is usefull for counting non-zero elements

    count = 0;
    
    dims = size(Arr);
    for c=1:dims(1)
        if(Arr(c,1) == 0 && Arr(c,2) == 0)
            break;
        end
        count = count + 1;
    end
end