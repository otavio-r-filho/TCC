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
                
                if (((lineAngle-e) <= mapAngle && mapAngle <= (lineAngle+e)) || ((lineAngle+pi-e) <= mapAngle && mapAngle <= (lineAngle+pi+e)) || ((lineAngle-pi-e) <= mapAngle && mapAngle <= (lineAngle-pi+e)))

                    if (pdist([Prm;Pql]) <= d && pdist([Pqm;Prl]) > pdist([Pqm;Prm]))
                        map(:,:,j) = [Pqm;Prl];
                        break;
                    elseif (pdist([Prm;Prl]) <= d && pdist([Pqm;Pql]) > pdist([Pqm;Prm]))
                        map(:,:,j) = [Pqm;Pql];
                        break;
                    elseif (pdist([Pqm;Prl]) <= d && pdist([Pql;Prm]) > pdist([Pqm;Prm]))
                        map(:,:,j) = [Pql;Prm];
                        break;                     
                    elseif (pdist([Pqm;Pql]) <= d && pdist([Prl;Prm]) > pdist([Pqm;Prm]))
                        map(:,:,j) = [Prl;Prm];
                        break;             
                    elseif (abs(dist2line([Pqm; Prm], Pql)) <= hi && pdist([Pql;Prl]) > pdist([Pql;Prm]) && pdist([Pqm;Prl]) > pdist([Prl;Prm]))
                        if (pdist([Pqm;Prl]) > pdist([Pqm;Prm]))
                            map(:,:,j) = [Pqm;Prl];
                        end
                        break;
                    elseif (abs(dist2line([Pqm; Prm], Prl)) <= hi && pdist([Pql;Prl]) > pdist([Prl;Prm]) && pdist([Pqm;Pql]) > pdist([Pql;Prm]))
                        if (pdist([Pqm;Pql]) > pdist([Pqm;Prm]))
                            map(:,:,j) = [Pqm;Pql];
                        end
                        break;                        
                    elseif (abs(dist2line([Pqm; Prm], Prl)) <= hi && pdist([Pql;Prl]) > pdist([Prl;Pqm]) && pdist([Pqm;Pql]) < pdist([Pql;Prm]))
                        if (pdist([Pql;Prm]) > pdist([Pqm;Prm]))
                            map(:,:,j) = [Pql;Prm];
                        end
                        break;
                    elseif (abs(dist2line([Pqm; Prm], Pql)) <= hi && pdist([Pql;Prl]) > pdist([Pql;Pqm]) && pdist([Pqm;Prl]) < pdist([Prl;Prm]))
                        if (pdist([Prl;Prm]) > pdist([Pqm;Prm]))
                            map(:,:,j) = [Prl;Prm];
                        end
                        break;
                    elseif (j == mapLinesQty)
                        mapLinesQty = mapLinesQty+1;
                        map(:,:,mapLinesQty) = [Pql;Prl];
                        break;
                    end
                elseif (j == mapLinesQty)
                    mapLinesQty = mapLinesQty+1;    
                    map(:,:,mapLinesQty) = [Pql;Prl];
                    break;
                end
                j = j+1;
            end%Inner while end

            i = i+1;
        end %Outter while end
        
    end %IF end
    
end %end of function