# preamble needs to be user-settable to check the example data vs the problem data
BEGIN {
    if (preamble == "") {
        pre = 25;
    } else {
        pre = preamble;
    }
}
NR <= pre {
    i = (NR - 1) % pre + 1;
    prev[i] = $1;
    all[NR] = $1;
}
NR > pre {
    i = (NR - 1) % pre + 1;
    cond = 0;
    for (j in prev) {
        for (k in prev) {
            if (prev[j] + prev[k] == $1) {
                cond = 1;
                break;
            }
        }
        if (cond == 1) {
            break;
        }
    }
    if (cond == 0) {
        print "Fails condition; line", NR, "number", $1;
        # FIXME this is the first slow (several second) loop in AOC2020
        for (j in all) {
            for (k = 1; k < NR - j; k++) {
                # TODO define range in stdlib
                step = 0;
                for (l = 0; l <= k; l++) {
                    step += all[j + l];
                }
                if ($1 == step) {
                    # TODO define min max in stdlib
                    # between q, q + p
                    min = all[j];
                    max = all[j];
                    for (m = 0; m <= k; m++) {
                        val = all[j + m];
                        if (val < min) {
                            min = val;
                        } else if (val > max) {
                            max = val;
                        }
                    }
                    print "Found weakness; max + min:", max + min;
                }
            }
        }
        exit;
    }
    prev[i] = $1;
    all[NR] = $1;
}
