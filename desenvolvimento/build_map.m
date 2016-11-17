function map = build_map(map, P, s, hl, e, d, hi)
    [S, C, H] = segmentation(P, s);
    L = generate_lines(S, hl);
    map = join_lines(map, L, e, d, hi);
end