BEGIN {
    FS = "[ \n]"
    RS = "\n\n"
    valid = 0;
    valid2 = 0;
    split("byr iyr eyr hgt hcl ecl pid", reqfields);
    split("amb blu brn gry grn hzl oth", reqecl);
}
{
    delete passport;
    for (i = 1; i <= NF; i++) {
        split($i, kv, ":");
        passport[kv[1]] = kv[2];
    }
    for (i in reqfields) {
        if (!(reqfields[i] in passport)) {
            next;
        }
    }
    valid++;
    if (passport["byr"] < 1920 || passport["byr"] > 2002) { next; }
    if (passport["iyr"] < 2010 || passport["iyr"] > 2020) { next; }
    if (passport["eyr"] < 2020 || passport["eyr"] > 2030) { next; }
    if (passport["hgt"] ~ /^[0-9]+cm$/) {
        sub(/cm/, "", passport["hgt"]);
        if (passport["hgt"] < 150 || passport["hgt"] > 193) { next; }
    } else if (passport["hgt"] ~ /^[0-9]+in$/) {
        sub(/in/, "", passport["hgt"]);
        if (passport["hgt"] < 59 || passport["hgt"] > 76) { next; }
    } else { next; }
    if (passport["hcl"] !~ /^#[0-9a-f]{6}$/) { next; }
    eclok = 0;
    for (i in reqecl) {
        if (passport["ecl"] == reqecl[i]) { eclok = 1; }
    }
    if (eclok == 0) { next; }
    if (passport["pid"] !~ /^[0-9]{9}$/) { next; }
    valid2++;
}
END {
    print "Valid passports (first)", valid;
    print "Valid passports (second)", valid2;
}
