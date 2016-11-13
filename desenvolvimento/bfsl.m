function bfsl(L)
    syms Ys;
    syms Xs;
    syms z;
    a = 0;
    b = 0;
    n1 = 0;
    n2 = 0;
    teta = atan((L(1,2,1)-L(len(1),2,1))/(L(1,1,1)-L(len(1),1,1)));

    for c=1:len(1)
        a = a + ((L(c,2,1)-Ys)*(L(c,1,1)-Xs));
        b = b + (((L(c,1,1)-Xs)^2)-((L(c,2,1)-Ys)^2));

        n1 = n1 + (L(c,2,1)-Ys);
        n2 = n2 + (L(c,1,1)-Xs);
    end

    bfsl = a*(z^2) + b*z - a == 0;
    eq2 = n1*cos(teta) - n2*sin(teta) == 0;

    solSys = solve([bfsl, eq2], [Xs, Ys, z]);

    hs = (solSys.Ys(1) - L(1,2,1))*cos(teta) - (solSys.Xs(1) - L(1,1,1))*sin(teta);

    deltaX = hs*sin(teta);
    deltaY = hs*cos(teta);

    Q = [L(1,1,1)+deltaX(1) L(1,2,1)+deltaY(1)];
    R = [L(len(1),1,1)+deltaX(1) L(len(1),2,1)+deltaY(1)];

    subplot(211)
    plot(P(:,1), P(:,2), '.r', pos(1), pos(2), 'ob');
    axis([-3.5 3.5 -7 7]);
    axis equal;

    subplot(212)
    plot(Q, R, 'g',  pos(1), pos(2), 'ob');
    axis([-3.5 3.5 -7 7]);
    axis equal;

    drawnow;
end