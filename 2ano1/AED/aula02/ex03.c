#include <ctype.h>
#include <stdio.h>
#include <string.h>

void Permute(int *a, int *b, int *c) {
  const int temp = *c;
  *c = *b;
  *b = *a;
  *a = temp;
}

int main(void) {
  int a = 1, b = 2, c = 3;

  printf("Start:\n");
  printf("a: %d\n", a);
  printf("b: %d\n", b);
  printf("c: %d\n", c);

  for (int i = 0; i < 5; i++) {
    printf("Iteration %d\n", i);

    Permute(&a, &b, &c);

    printf("a: %d\n", a);
    printf("b: %d\n", b);
    printf("c: %d\n", c);
  }

  return 0;
}
