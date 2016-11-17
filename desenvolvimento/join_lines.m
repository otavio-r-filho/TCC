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
        while (i < linesQty)
            Pql = lines(1,1:2,i);
            Prl = lines(2,1:2,i);
            lineAngle = angleOfLine([Pql; Prl]);

            for j=1:mapLinesQty
                Pqm = map(1,1:2,j);
                Prm = map(2,1:2,j);
                mapAngle = angleOfLine([Pqm; Prm]);
                
                %Same direction and way
                if ((lineAngle-e) <= mapAngle <= (lineAngle+e))
                    if(pdist([Prm;Pql]) <= d)
                        map(:,:,j) = [Pqm;Prl];
                        break;
                    elseif(pdist([Pqm;Prl]) <= d)
                        map(:,:,j) = [Pql;Prm];
                        break;
                    elseif(dist2line([Pqm; Prm], Pql) <= hi && pdist([Pql;Prl]) > pdist([Pql;Prm]))
                        map(:,:,j) = [Pqm;Prl];
                        break;
                    elseif(dist2line([Pqm; Prm], Prl) <= hi && pdist([Pql;Prl]) > pdist([Prl;Pqm]))
                        map(:,:,j) = [Pql;Prm];
                        break;
                    else
                        if(j == mapLinesQty)
                            map(:,:,j+1) = [Pql;Prl];
                        end
                    end
                %Same direction and opposite ways
                elseif ((lineAngle+(2*pi)-e) <= mapAngle <= (lineAngle+(2*pi)+e))
                    if(pdist([Pqm; Pql]) <= d)
                        map(:,:,j) = [Prl;Prm];
                        break;
                    elseif(pdist([Prm;Prl]) <= d)
                        map(:,:,j) = [Pqm;Pql];
                        break;
                    elseif(dist2line([Pqm; Prm], Prl) <= hi && pdist([Pql;Prl]) > pdist([Prl;Prm]))
                        map(:,:,j) = [Pqm;Pql];
                        break;
                    elseif(dist2line([Pqm; Prm], Pql) <= hi && pdist([Pql;Prl]) > pdist([Pql;Pqm]));
                        map(:,:,j) = [Prl;Prm];
                        break;
                    else
                        if(j == mapLinesQty)
                            map(:,:,j+1) = [Pql;Prl];
                        end
                    end
                end %IF end

            end %FOR end
            i = i+1;
        end 
        
    end 
end %end of function