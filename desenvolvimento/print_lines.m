function print_lines(P1, P2)
subplot(211);
plot(P1(:,1), P1(:,2), 'b', P2(:,1), P2(:,2), 'r');
axis([-7 7 -7 7]);
axis equal;
drawnow;
end