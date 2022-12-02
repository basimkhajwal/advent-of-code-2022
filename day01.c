#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) { return a > b ? a : b; }

int main() {

  FILE* fp;
  char* line = NULL;
  size_t len, buf_len;

  fp = fopen("input/day01.txt", "r");
  if (fp == NULL) {
    printf("Error opening file\n");
    return -1;
  }

  int blocks[4];
  for (int i = 0; i < 4; i++) blocks[i] = 0;

  while (1) {
    len = getline(&line, &buf_len, fp);
    if (len == -1 || len == 0 || line[0] == '\n') {
      for (int i = 3; i > 0 && blocks[i] > blocks[i-1]; --i) {
        int tmp = blocks[i];
        blocks[i] = blocks[i-1];
        blocks[i-1] = tmp;
      }
      blocks[3] = 0;
      if (len == -1 || len == 0) break;
    } else {
      int d;
      sscanf(line, "%d", &d);
      blocks[3] += d;
    }
  }

  printf("Max block: %d\n", blocks[0]);
  printf("Top three: %d\n", blocks[0]+blocks[1]+blocks[2]);

  return 0;
}
