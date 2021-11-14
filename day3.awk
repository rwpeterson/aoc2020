BEGIN {
    split("1:1 1:3 1:5 1:7 2:1", slope, " "); # dy:dx
}
{
    if (NR == 1) {
        w = length($1);
        for (s in slope) {
            xs[slope[s]] = 1;
        }
    } else {
        for (s in slope) {
            split(slope[s], d, ":")
            dy = d[1];
            dx = d[2];
            if (dy == 1 || ((NR+1) % dy == 0)) {
                xs[slope[s]] += dx;
                if (substr($1, 1 + ((xs[slope[s]] - 1) % w), 1) == "#") {
                    trees[slope[s]]++;
                }
            }
        }
    }
}
END {
    prod = 1;
    for (s in slope) {
        print slope[s], trees[slope[s]];
        prod *= trees[slope[s]];
    }
    print "product", prod
}
