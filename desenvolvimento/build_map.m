function map = build_map(map, P, s, hl, e, d, hi)
    [S, C, H] = segmentation(P, s);
    L = generate_lines(S, hl);
    BFL = bfsl(L);
    map = join_lines(map, BFL, e, d, hi);
end