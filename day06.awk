{ input_string = input_string $0 }
END {

l = length(input_string)
sz = 14 # 4

for (i = 1; i <= l; i++) {
  same = 1
  # Loop through the next four characters in the input string
  for (j = i; j < i+sz && j <= l; j++) {
    for (k = j+1; k < i+sz && k <= l; k++) {
      if (substr(input_string, j, 1) == substr(input_string, k, 1)) {
        same = 0
      }
    }
  }
  if (same == 1) {
    print (i+sz-1)
    break
  }
}
}
