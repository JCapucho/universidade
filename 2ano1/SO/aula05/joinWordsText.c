#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
  int string_size = 0;

  for (int i = 1; i < argc; i++) {
    string_size += strlen(argv[i]);
  }

  // Plus one for null byte
  char *result = (char *)malloc(string_size + 1);
  if (result == NULL)
    return EXIT_FAILURE;

  *result = '\0';

  for (int i = 1; i < argc; i++) {
    const char *arg = argv[i];
    if (isalpha(*arg))
      strcat(result, arg);
  }

  printf("Resultado: \"%s\"\n", result);

  free(result);

  return EXIT_SUCCESS;
}
