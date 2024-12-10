#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SUGESTÂO: utilize as páginas do manual para conhecer mais sobre as funções
 usadas: man qsort
*/

#define LINEMAXSIZE 80
#define MAXNUMBERS 100

int compareInts(const void *px1, const void *px2) {
  int x1 = *((int *)px1);
  int x2 = *((int *)px2);
  return (x1 < x2 ? -1 : x1 == x2 ? 0 : 1);
}

int main(int argc, char *argv[]) {
  int i, numSize;
  int *numbers;
  char line[LINEMAXSIZE];

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
  numbers = (int *)malloc(sizeof(int) * MAXNUMBERS);

  numSize = 0;
  while (fgets(line, sizeof(line), fp) != NULL) {
    if (numSize >= MAXNUMBERS) {
      fprintf(stderr, "File has more numbers than were allocated");
      return EXIT_FAILURE;
    }

    size_t read_bytes = strlen(line);
    if (read_bytes == 0)
      continue;

    if (line[read_bytes - 1] == '\n')
      line[read_bytes - 1] = '\0';

    numbers[numSize++] = atoi(line);
  }

  /* void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void
     *, const void *)); The qsort() function sorts an array with nmemb elements
     of size size.*/
  qsort(numbers, numSize, sizeof(int), compareInts);

  /* Printing the sorted numbers */
  printf("Sorted numbers: \n");
  for (i = 0; i < numSize; i++) {
    printf("%d\n", numbers[i]);
  }

  fclose(fp);

  return EXIT_SUCCESS;
}
