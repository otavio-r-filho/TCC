function map = join_lines(map, lines, e, d, hi)
    if(isempty(map))
        map = lines;
    else
        dimMap = size(map);
        dimLines = size(lines);

        if(length(dimMap) == 3)
            mapLinesQty = dimMap(3);
        else
            mapLinesQty = 1;
        end

        if(length(dimLines) == 3)
            linesQty = dimLines(3);
        else
            linesQty = 1;
        end

        i = 1;
        while (i <= linesQty)
            Pql = lines(1,1:2,i);
            Prl = lines(2,1:2,i);
            lineAngle = angleOfLine([Pql; Prl]);
            
            j=1;
            while (j <= mapLinesQty)
                Pqm = map(1,1:2,j);
                Prm = map(2,1:2,j);
                mapAngle = angleOfLine([Pqm; Prm]);
                
                
                if (((lineAngle-e) <= mapAngle <= (lineAngle+e)) || ((lineAngle+(2*pi)-e) <= mapAngle <= (lineAngle+(2*pi)+e)))

                    if (pdist([Prm;Pql]) <= d)
                        map(:,:,j) = [Pqm;Prl];
                    elseif (pdist([Prm;Prl]) <= d)
                        map(:,:,j) = [Pqm;Pql];
                    elseif (pdist([Pqm;Prl]) <= d)
                        map(:,:,j) = [Pql;Prm];
                    elseif (pdist([Pqm;Pql]) <= d)
                        map(:,:,j) = [Prl;Prm];
                    elseif (abs(dist2line([Pqm; Prm], Pql)) <= hi && pdist([Pql;Prl]) > pdist([Pql;Prm]))
                        map(:,:,j) = [Pqm;Prl];
                    elseif (abs(dist2line([Pqm; Prm], Prl)) <= hi && pdist([Pql;Prl]) > pdist([Prl;Prm]))
                        map(:,:,j) = [Pqm;Pql];
                    elseif (abs(dist2line([Pqm; Prm], Prl)) <= hi && pdist([Pql;Prl]) > pdist([Prl;Pqm]))
                        map(:,:,j) = [Pql;Prm];
                    elseif (abs(dist2line([Pqm; Prm], Pql)) <= hi && pdist([Pql;Prl]) > pdist([Pql;Pqm]))
                        map(:,:,j) = [Prl;Prm];
                    elseif (j == mapLinesQty)
                        mapLinesQty = mapLinesQty+1;
                        map(:,:,mapLinesQty) = [Pql;Prl];
                    end
                else
                    mapLinesQty = mapLinesQty+1;    
                    map(:,:,mapLinesQty) = [Pql;Prl];
                end
                j = j+1;
            end%Inner while end

            i = i+1;
        end %Outter while end
        
    end %IF end
    
end %end of function