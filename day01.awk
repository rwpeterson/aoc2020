BEGIN {
    i = 0;
}

{
    expense[i++] = $1;
}

END {
    found2 = 0;
    found3 = 0;
    for (i in expense) {
        for (j in expense) {
            if ((expense[i] + expense[j] == 2020) && !found2) {
                found2 = 1;
                print "2x2", expense[i] * expense[j];
            }
            for (k in expense) {
                if ((expense[i] + expense[j] + expense[k] == 2020) && !found3) {
                    found3 = 1;
                    print "3x3x3", expense[i] * expense[j] * expense[k];
                }
            }
        }
    }
}
