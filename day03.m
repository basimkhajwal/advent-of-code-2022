f = fopen("input/day03.txt");
score = 0;

while (l = fgetl(f)) != -1
    n = length(l);
    m = n / 2;  
    a = unique(l(1:m));
    b = unique(l((m+1):n));
    v = intersect(a,b);
    score += [v-'a'+1,v-'A'+27]((v<'a')+1);
endwhile

printf("Part 1: %d\n", score);

f = fopen("input/day03.txt");
score = 0;

while (l1 = fgetl(f)) != -1
    l2 = fgetl(f);
    l3 = fgetl(f);
    v = intersect(
            unique(l1),
            intersect(unique(l2),unique(l3))
        );
    score += [v-'a'+1,v-'A'+27]((v<'a')+1);
endwhile
printf("Part 2: %d\n", score);