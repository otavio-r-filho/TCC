function len = dimension_length(Arr)
%   This function cumputes the length of the given cluster dimension. It
%   stops when a zero line is found.
%   from num. This is usefull for counting non-zero elements

    count = 0;
    len = [];
    
    dims = size(Arr);
    
%     for c=1:dims(1)
%         if(Arr(c,1) == 0 && Arr(c,2) == 0)
%             break;
%         end
%         count = count + 1;
%     end
    if length(dims) < 3
        d = 1;
    else
        d = dims(3);
    end
    
    for i = 1:d
        for j = 1:dims(1)
            if(Arr(j,1,i) == 0 && Arr(j,2,i) == 0)
                break;
            end
            count = count + 1;
        end
        len(i) = count;
        count = 0;
    end
end