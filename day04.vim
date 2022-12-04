let includes = 0
let overlaps = 0
for line in readfile("input/day04.txt")
  let [a,b,c,d] = map(split(line, '\-\|,'), 'str2nr(v:val)')
  if (a <= c && d <= b) || (c <= a && b <= d)
    let includes += 1
  endif
  if !(d < a || b < c)
    let overlaps += 1
  endif
endfor

echo includes
echo overlaps
