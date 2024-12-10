#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp_string(const void *a, const void *b) {
  fprintf(stderr, "%s %s %d\n", a, b, strcmp(a, b));
  return strcmp(a, b);
}

int main(int argc, char **argv) {
  int order = 1;
  char *sort_order = getenv("USER");

  if (sort_order != NULL) {
    if (strcmp(sort_order, "crescente")) {
      order = 1;
    } else if (strcmp(sort_order, "decresecent")) {
      order = -1;
    } else {
      fprintf(stderr, "Ordenação desconhecida \"%s\"\n", sort_order);
      return EXIT_FAILURE;
    }
  }

  size_t sorted_size = 0;
  char *sorted[argc];

  for (int i = 1; i < argc; i++) {
    if (isalpha(*argv[i]))
      sorted[sorted_size++] = argv[i];
  }

  qsort(sorted, sorted_size, sizeof(sorted[0]), cmp_string);

  for (size_t i = 0; i < sorted_size; i++) {
    printf("%s\n", sorted[i]);
  }

  return EXIT_SUCCESS;
}
