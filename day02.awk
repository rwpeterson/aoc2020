BEGIN {
    valid = 0;
    validb = 0;
    FS = "[ -]"
}
{
    # 1-9 a: asdflasd
    min = $1;
    max = $2;
    char = substr($3, 1, 1);
    passwd = $4;
    count = 0;
    while (i = index(passwd, char)) {
       count++;
       passwd = substr(passwd, 1, i - 1) substr(passwd, i + 1);
    }
    if ((min <= count) && (count <= max)) {
        valid++;
    }
}
{
    i = $1;
    j = $2;
    char = substr($3, 1, 1);
    passwd = $4;
    if ((substr(passwd, i, 1) == char && substr(passwd, j, 1) != char) || (substr(passwd, i, 1) != char && substr(passwd, j, 1) == char)) {
        validb++;
    }
}
END {
    print "Valid passwords (first part):", valid;
    print "Valid passwords (second part):", validb;
}
