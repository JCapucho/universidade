#include <stddef.h>
#include <stdio.h>

void printArray(char *s, int *a, size_t a_length) {
  printf("%s:\n", s);

  for (size_t i = 0; i < a_length; i++)
    printf("%d ", a[i]);

  printf("\n");
}

void cumSum(int *a, size_t a_length, int *b) {
  int c = 0;

  for (size_t i = 0; i < a_length; i++) {
    c += a[i];
    b[i] = c;
  }
}

int main(void) {
  int a[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  printArray("a", a, sizeof(a) / sizeof(int));

  int b[12];
  cumSum(a, sizeof(a) / sizeof(int), b);
  printArray("b", b, sizeof(b) / sizeof(int));

  return 0;
}
