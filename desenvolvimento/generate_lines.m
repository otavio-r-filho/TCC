function lines = generate_lines(S, e)
    lines = [];
    dims = size(S);
    k = 1;
    
    if(~isempty(S))
        if(length(dims)==3)
            for i=1:dims(3)
                len = dimension_length(S);
                Pq = S(1,1:2,i);
                Pr = S(len(i),1:2,i);
                %teta = atan((Pq(2)-Pr(2))/(Pq(1)-Pr(1)));
                teta = angleOfLine([Pq; Pr]);
                maxH = [0 -1]; %Max H is h and index
                for j=2:(len(i)-1)
                    h = abs((S(j,2,i) - Pr(2))*cos(teta) - (S(j,1,i) - Pr(1))*sin(teta));
                    if(maxH(1) < h && h > e)
                        maxH = [h j];
                    end
                end
                if(maxH(1) > 0)
                    lines(1:maxH(2),1:2,k) = S(1:maxH(2),1:2,i);
                    k = k+1;
                    lines(1:(len(i)-maxH(2)+1),1:2,k) = S(maxH(2):len(i),1:2,i);
                    k = k+1;
                else
                    lines(1:len(i),1:2,k) = S(1:len(i),1:2,i);
                    k = k+1;                 
                end
            end
        else
            Pq = S(1,1:2);
            Pr = S(len(1),1:2);
            teta = atan((Pq(2)-Pr(2))/(Pq(1)-Pr(1)));
            maxH = [0 -1] %Max H is h and index
            for i = 1:len(1)              
                h = (S(i,2) - Pr(2))*cos(teta) - (S(i,1) - Pr(1))*sin(teta);
                if(maxH(1) < h && h > e)
                    maxH = [h i];
                end
            end
            if(maxH(1) > 0)
                lines(1:maxH(2),1:2,k) = S(1:maxH(2),1:2,i);
                k = k+1;
                lines(1:(len(1)-maxH(2)+1),1:2,k) = S(maxH(2):len(i),1:2,i);
                k = k+1;
            else
                lines(1:len(i),1:2,k) = S(1:len(i),1:2,i);
                k = k+1;
            end
        end
    end
    
    
end