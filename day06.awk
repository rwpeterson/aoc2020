BEGIN {
    FS = "";
}
{
    if (NF == 0) {
        sum += length(as);
        for (i in as) {
            if (as[i] == ct) {
                sum2++;
            }
        }
        delete as;
        ct = 0;
    } else {
        ct++;
        for (i = 1; i <= NF; i++) {
            as[$i]++;
        }
    }
}
END {
    sum += length(as);
    for (i in as) {
        if (as[i] == ct) {
            sum2++;
        }
    }
    print "Sum of group questions", sum
    print "Sum of all-group questions", sum2
}
