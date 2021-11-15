# TODO: define tree operations in stdlib
function contains(map, start, end) {
    if (start == end) {
        return 1;
    }
    if (isarray(map[start])) {
        for (node in map[start]) {
            if (contains(map, node, end)) {
                return 1;
            }
        }
    }
    return 0;
}
function countnodes(map, start,    acc) {
    if (isarray(map[start])) {
        for (node in map[start]) {
            acc += map[start][node] * (1 + countnodes(map, node));
        }
    }
    return acc;
}
BEGIN {
    FS = " bags contain ";
}
{
    split($2, cs, ", ");
    colors[$1]++;
    for (i in cs) {
        if (cs[i] ~ /no other bags/) {
            rules[$1] = "NULL";
        } else {
            n = substr(cs[i], 1, index(cs[i], " ") - 1);
            c = cs[i];
            sub(/^[0-9]+ /, "", c);
            sub(/ bags?\.?/, "", c);
            rules[$1][c] = n;
        }
    }
}
END {
    for (color in colors) {
        if (color == "shiny gold") {
            continue;
        }
        if (contains(rules, color, "shiny gold")) {
            bagcolors++;
        }
    }
    print "Number of bag colors that contain shiny gold bags", bagcolors;
    print "Total number of bags inside a shiny gold bag", countnodes(rules, "shiny gold");
}
