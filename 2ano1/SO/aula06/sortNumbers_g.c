#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SUGESTÂO: utilize as páginas do manual para conhecer mais sobre as funções
 usadas: man qsort
*/

int compareInts(const void *px1, const void *px2) {
  int x1 = *((int *)px1);
  int x2 = *((int *)px2);
  return (x1 < x2 ? -1 : x1 == x2 ? 0 : 1);
}

int main(int argc, char *argv[]) {
  size_t allocated = 2, numSize = 0;
  int *numbers;

  /* Validate number of arguments */
  if (argc != 2) {
    printf("USAGE: %s fileName\n", argv[0]);
    return EXIT_FAILURE;
  }

  /* Open the file provided as argument */
  errno = 0;
  FILE *fp = fopen(argv[1], "r");
  if (fp == NULL) {
    perror("Error opening file!");
    return EXIT_FAILURE;
  }

  /* Memory allocation for all the numbers in the arguments */
  numbers = (int *)malloc(sizeof(int) * allocated);
  if (numbers == NULL) {
    perror("Error allocating memory!");
    return EXIT_FAILURE;
  }

  numSize = 0;
  while (1) {
    if (numSize >= allocated) {
      allocated *= 2;
      fprintf(stderr, "Reallocing %lu numbers\n", allocated);
      numbers = realloc(numbers, sizeof(int) * allocated);
      if (numbers == NULL) {
        perror("Error allocating memory!");
        return EXIT_FAILURE;
      }
    }

    if (fscanf(fp, "%d", &numbers[numSize]) != 1)
      break;

    numSize++;
  }

  /* void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void
     *, const void *)); The qsort() function sorts an array with nmemb elements
     of size size.*/
  qsort(numbers, numSize, sizeof(int), compareInts);

  /* Printing the sorted numbers */
  printf("Sorted numbers: \n");
  for (size_t i = 0; i < numSize; i++) {
    printf("%d\n", numbers[i]);
  }

  free(numbers);
  fclose(fp);

  return EXIT_SUCCESS;
}
