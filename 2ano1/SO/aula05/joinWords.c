#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
  int string_size = 1;

  for (int i = 1; i < argc; i++) {
    string_size += strlen(argv[i]);
  }

  string_size += argc - 2;

  // Plus one for null byte
  char *result = (char *)malloc(string_size);
  if (result == NULL)
    return EXIT_FAILURE;

  *result = '\0';

  for (int i = 1; i < argc; i++) {
    size_t count = strlen(result);
    if (i > 1) {
      result[count] = ' ';
      result[count + 1] = '\0';
    }
    strcat(result, argv[i]);
  }

  printf("Resultado: \"%s\"\n", result);

  free(result);

  return EXIT_SUCCESS;
}
