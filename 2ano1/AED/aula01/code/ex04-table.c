#include <math.h>
#include <stdio.h>

int main(void) {
  int linhas = 5;

  printf("Número | Quadrado | Raiz\n");

  for (int i = 1; i <= linhas; i++) {
    printf("%d | %d | %f\n", i, i * i, sqrt(i));
  }

  return 0;
}
