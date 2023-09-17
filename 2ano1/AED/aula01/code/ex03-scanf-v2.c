#include <stdio.h>

int main(void) {
  char name[5];

  if (scanf("%4s", name) != 1)
    return 1;

  printf("Hello %s\n", name);
  return 0;
}
