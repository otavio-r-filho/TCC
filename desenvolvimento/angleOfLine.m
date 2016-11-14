function angle = angleOfLine(line)
    Xq = line(1,1);
    Yq = line(1,2);
    Xr = line(2,1);
    Yr = line(2,2);
    angle = atan((Yq-Yr)/(Xq-Xr));
end