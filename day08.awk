function eval(is, vs) {
    i = 1;
    delete visited;
    for (;;) {
        if (visited[i]) {
            return "LOOP";
        }
        if (i == NR + 1) {
            return "OK";
        }
        if (i > NR || i < 1) {
            return "OOB";
        }
        visited[i]++;
        if (instr[i] == "acc") {
            acc += val[i];
            i++;
        } else if (instr[i] == "nop") {
            i++;
        } else if (instr[i] == "jmp") {
            i += val[i];
        }
    }
}
{
    instr[NR] = $1;
    val[NR] = $2;
}
END {
    acc = 0;
    status = eval(instr, val);
    if (status == "LOOP") {
        print "infinite loop; acc:", acc;
    }
    for (i in instr) {
        if (instr[i] == "nop") {
            nops[i]++;
        } else if (instr[i] == "jmp") {
            jmps[i]++;
        }
    }
    for (j in jmps) {
        acc = 0;
        instr[j] = "nop"
        if (eval(instr, val) == "OK") {
            print "line to switch:", j, "acc:", acc;
            exit;
        }
        instr[j] = "jmp";
    }
    for (k in nops) {
        acc = 0;
        instr[k] = "jmp"
        if (eval(instr, val) == "OK") {
            print "line to switch:", k, "acc:", acc;
            exit;
        }
        instr[k] = "nop";
    }
}
