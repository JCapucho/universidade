#include <math.h>
#include <stdio.h>
#include <string.h>

int max(int a, int b) { return a >= b ? a : b; }

int main(void) {
  int linhas = 5;

  // Cabeçalhos
  char *number_header = "Numero";
  char *square_header = "Quadrado";
  char *root_header = "Raiz";

  // Tamanho máximo dos números em cada colunas.
  //
  // Todas estas funções são crescentes para números naturais,
  // logo basta calcular para o maior número.
  int max_number_width = snprintf(NULL, 0, "%d", linhas);
  int max_square_width = snprintf(NULL, 0, "%d", linhas * linhas);
  int max_root_width = snprintf(NULL, 0, "%.5f", sqrt(linhas));

  // Tamanho dos cabeçalhos
  int number_header_size = strlen(number_header);
  int square_header_size = strlen(square_header);
  int root_header_size = strlen(root_header);

  // Tamanho das colunas
  int first_column_size = max(max_number_width, number_header_size);
  int second_column_size = max(max_square_width, square_header_size);
  int third_column_size = max(max_root_width, root_header_size);

  // Imprimir o cabeçalho
  printf(" %*s | %*s | %*s \n", first_column_size, number_header,
         second_column_size, square_header, third_column_size, root_header);

  // Imprimir as linhas
  for (int i = 1; i <= linhas; i++) {
    printf(" %*d | %*d | %*.5f \n", first_column_size, i, second_column_size,
           i * i, third_column_size, sqrt(i));
  }

  return 0;
}
