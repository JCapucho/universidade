#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SUGESTÂO: utilize as páginas do manual para conhecer mais sobre as funções
 usadas: man fopen man fgets
*/

#define LINEMAXSIZE 80 /* or other suitable maximum line size */

int main(int argc, char *argv[]) {
  FILE *fp = NULL;
  char line[LINEMAXSIZE];

  /* Validate number of arguments */
  if (argc < 2) {
    printf("USAGE: %s fileName\n", argv[0]);
    return EXIT_FAILURE;
  }

  for (int i = 1; i < argc; i++) {
    const char *file_path = argv[i];

    /* Open the file provided as argument */
    errno = 0;
    fp = fopen(file_path, "r");
    if (fp == NULL) {
      perror("Error opening file!");
      return EXIT_FAILURE;
    }

    size_t line_number = 1;
    /* Read all the lines of the file */
    while (fgets(line, sizeof(line), fp) != NULL) {
      /* not needed to add '\n' to printf because fgets will read
         the '\n' that ends each line in the file */
      printf("%lu -> %s", line_number++, line);

      size_t bytes_read = strlen(line);
      if (bytes_read == 0)
        continue;

      while (line[bytes_read - 1] != '\n') {
        if (fgets(line, sizeof(line), fp) == NULL)
          break;

        printf("%s", line);
        bytes_read = strlen(line);
        if (bytes_read == 0)
          break;
      }
    }

    fclose(fp);
  }

  return EXIT_SUCCESS;
}
