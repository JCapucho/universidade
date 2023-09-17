#include <stdio.h>

int main(void) {
  char name[5];

  if (fgets(name, 5, stdin) == NULL)
    return 1;

  // Vamos iterar pela string para remover o carater de
  // linha nova.
  for (int i = 0; i < 5; i++) {
    // Temos que garantir que não processamos dados após
    // o byte nulo, pois estes não foram inicializados
    // sendo UB ler esses bytes.
    if (name[i] == '\0')
      break;

    // Substituimos a linha nova pelo byte nulo para terminar
    // a string e terminamos de processar a string.
    if (name[i] == '\n') {
      name[i] = '\0';
      break;
    }
  }

  printf("Hello %s\n", name);
  return 0;
}
