#include <stdio.h>
#include <stdlib.h>

unsigned int valor_maximo(size_t n, unsigned int *moedas) {
  if (n == 0)
    return 0;

  if (n == 1)
    return moedas[0];

  unsigned int adjacente = valor_maximo(n - 1, moedas);
  unsigned int par = moedas[n - 1] + valor_maximo(n - 2, moedas);
  return par > adjacente ? par : adjacente;
}

int main(void) {
  unsigned int max_k;
  printf("Calcular até: ");
  if (scanf("%u", &max_k) != 1)
    return 1;

  unsigned int moedas[max_k];

  srand(0);
  for (size_t i = 0; i < max_k; i++) {
    moedas[i] = rand() % 20 + 5;
  }

  unsigned int f1_res =
      valor_maximo(sizeof(moedas) / sizeof(unsigned int), moedas);
  printf("%u\n", f1_res);

  return 0;
}
