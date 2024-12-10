#include <stdio.h>

static unsigned int NUM_CHAMADAS = 0;

unsigned long function1(unsigned int n) {
  if (n == 1)
    return 1;

  NUM_CHAMADAS++;
  return function1(n / 2) + n;
}

unsigned long function2(unsigned int n) {
  if (n == 1)
    return 1;

  NUM_CHAMADAS += 2;
  return function2(n / 2) + function2((n + 1) / 2) + n;
}

unsigned long function3(unsigned int n) {
  if (n == 1)
    return 1;

  if (n % 2 == 0) {
    NUM_CHAMADAS++;
    return 2 * function3(n / 2) + n;
  } else {
    NUM_CHAMADAS += 2;
    return function3(n / 2) + function3((n + 1) / 2) + n;
  }
}

int main(void) {
  unsigned int max_n;
  printf("Calcular até: ");
  if (scanf("%u", &max_n) != 1)
    return 1;

  printf("  N  | f1(N) | chamadas | f2(N) | chamadas | f3(N) | chamadas\n");
  printf("-----+-------+----------+-------+----------+-------+----------\n");
  for (unsigned int n = 1; n <= max_n; n++) {
    printf("%4u", n);

    NUM_CHAMADAS = 0;
    unsigned long f1_res = function1(n);
    printf(" | %5lu | %8u", f1_res, NUM_CHAMADAS);

    NUM_CHAMADAS = 0;
    unsigned long f2_res = function2(n);
    printf(" | %5lu | %8u", f2_res, NUM_CHAMADAS);

    NUM_CHAMADAS = 0;
    unsigned long f3_res = function3(n);
    printf(" | %5lu | %8u\n", f3_res, NUM_CHAMADAS);
  }

  return 0;
}
