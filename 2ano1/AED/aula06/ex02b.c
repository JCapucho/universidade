#include <stdio.h>

unsigned int valor_maximo(unsigned int n, unsigned int *moedas) {
  if (n == 0)
    return 0;

  if (n == 1)
    return moedas[0];

  unsigned int adjacente = valor_maximo(n - 1, moedas);
  unsigned int par = moedas[n - 1] + valor_maximo(n - 2, moedas);
  return par > adjacente ? par : adjacente;
}

int main(void) {
  unsigned int moedas[] = {5, 1, 2, 10, 6, 2};

  unsigned int f1_res =
      valor_maximo(sizeof(moedas) / sizeof(unsigned int), moedas);
  printf("%u\n", f1_res);

  return 0;
}
