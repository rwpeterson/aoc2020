function bin2dec(b) {
    n = length(b)
    d = 0;
    for (i = 1; i <= n; i++) {
        if (substr(b, i, 1) == "1") {
            d += 2 ** (n - i);
        }
    }
    return d
}
BEGIN {
    largest_id = 0;
}
{
    row = substr($1, 1, 7);
    col = substr($1, 8, 3);
    gsub(/B/, "1", row);
    gsub(/F/, "0", row);
    row = bin2dec(row);
    gsub(/R/, "1", col);
    gsub(/L/, "0", col);
    col = bin2dec(col);
    id = 8 * row + col;
    ids[id] = id;
    if (id > largest_id) {
        largest_id = id;
    }
}
END {
    print "Largest ticket ID", largest_id
    q = 0;
    for (i = 1; i <= asort(ids); i++) {
        q = p;
        p = ids[i];
        if (q + 2 == p) {
            print "My ticket ID", q + 1;
        }
    }
}
