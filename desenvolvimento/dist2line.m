function h = dist2line(ln, pt)
	teta = atan((ln(1,2) - ln(2,2))/(ln(1,1) - ln(2,1)));
	h = (pt(2) - ln(1,2))*cos(teta) - (pt(1) - ln(1,1))*sin(teta);
end