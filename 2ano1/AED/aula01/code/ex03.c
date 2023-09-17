#include <stdio.h>

int main(void) {
  char nome[20];
  char apelido[20];

  printf("Nome: ");
  if (scanf("%19[^\n]", nome) != 1)
    return 1;

  // Discard newlines from stdin so that the next `scanf`
  // doesn't return immediately.
  while (1) {
    char c = getchar();

    if (c == '\n' || c == EOF)
      break;
  }

  printf("Apelido: ");
  if (scanf("%19[^\n]", apelido) != 1)
    return 1;

  printf("Hello %s %s!\n", nome, apelido);
  return 0;
}
