//
// Tomás Oliveira e Silva, AED, October 2021
//
// explain the program output
//
// try also compiling the program with the -Wsign-compare compilation flag
//

#include <limits.h>
#include <stdio.h>

int main(void) {
  unsigned int i = 1;
  int j = -1;
  int k = -2147483648;

  printf("original i = %u\n", i);
  printf("original j = %d\n", j);
  printf("original k = %d\n", k);

  // compare i with j
  if (i > j)
    printf("i > j is true\n");
  else
    // Vai executar este porque como `i` tem um
    // tipo mais especificado `unsigned int`, o
    // compilador vai promover `j` também a esse
    // tipo, mas como -1 é representado como 2^32-1
    // `j` será maior numa comparação unsigned.
    printf("i > j is false\n");

  // replace k by its absolute value and print the result
  if (k < 0)
    k = -k;

  // Isto vai continuar a ser -2147483648, porque
  // o valor absoluto 2147483648 está fora do valores
  // que podem ser representados por um int, o que causa
  // com que a negação volte a ativar o bit mais significativo
  // e o número a voltar ao seu valor inicial.
  printf("absolute value of k = %d\n", k);

  printf("Integer representable range: (%d)---(%d)\n", INT_MIN, INT_MAX);

  return 0;
}
