function map = join_lines(map, lines, e, d, s)
    dimMap = size(map);
    dimLines = size(line);
    
    %Measuring the angles of the lines
    % for (i=1:dimMap(3))
    %     mapAngle(i) = angleOfLine(map(:,:,i));
    % end
    
    % for (i=1:dimLines(3))
    %     linesAngle = angleOfLine(lines(:,:,i));
    % end
    
    if(isempty(map))
        map = lines;
    else
        dimMap = size(map);
        dimLines = size(line);

        if(length(dimMap) == 3)
            i = 1;
            while (i < dimLines(3))
                Pql = lines(1,1:2,i);
                Prl = lines(2,1:2,i);
                lineAngle = angleOfLine([Pql; Prl]);

                for j=1:dimMap(3)
                    Pqm = map(1,1:2,j);
                    Prm = map(2,1:2,j);
                    mapAngle = angleOfLine([Pqm; Prm]);
                    
                    %Same direction and way
                    if ((linesAngle-e) <= mapAngle(j) <= (linesAngle+e))
                        if(pdist([Prm;Pql]) <= d)
                            map(:,:,j) = [Pqm;Prl];
                            break;
                        elseif(pdist([Pqm;Prl] <= d)
                            map(:,:,j) = [Pql;Prm];
                            break;
                        elseif(dist2line([Pqm; Prm], Pql) <= s && pdist([Pql;Prl]) > pdist([Pql;Prm])
                            map(:,:,j) = [Pqm;Prl];
                            break;
                        elseif(dist2line([Pqm; Prm], Prl) <= s && pdist([Pql;Prl]) > pdist([Prl;Pqm])
                            map(:,:,j) = [Pql;Prm];
                            break;
                        else
                            if(j == dimMap(3))
                                map(:,:,j+1) = [Pql;Prl];
                            end
                        end
                    %Same direction and opposite ways
                    elseif ((linesAngle+(2*pi)-e) <= mapAngle(j) <= (linesAngle+(2*pi)+e))
                        if(pdist([Pqm; Pql]) <= d)
                            map(:,:,j) = [Prl;Prm];
                            break;
                        elseif(pdist([Prm;Prl]) <= d)
                            map(:,:,j) = [Pqm;Pql];
                            break;
                        elseif(dist2line([Pqm; Prm], Prl) <= s && pdist([Pql;Prl]) > pdist([Prl;Prm])
                            map(:,:,j) = [Pqm;Pql];
                            break;
                        elseif(dist2line([Pqm; Prm], Pql) <= s && pdist([Pql;Prl]) > pdist([Pql;Pqm])
                            map(:,:,j) = [Prl;Prm];
                            break;
                        else
                            if(j == dimMap(3))
                                map(:,:,j+1) = [Pql;Prl];
                            end
                        end
                    end %IF end

                end %FOR end
                i = i+1;
            end 
        end
    end
end %end of function