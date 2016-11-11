function plot_range(pts, ini, fin, pos)
    if (ini <= fin) 
        for c = ini:fin;
            %subplot(211)
            plot(pts(c,1), pts(c,2), '.r', pos(1), pos(2), 'ob');
            axis([-5 5 -5 5]);
            axis equal;
            drawnow;
        end
    else
        disp('Invalid dimensions!')
    end
end