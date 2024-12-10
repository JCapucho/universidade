#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* SUGESTÂO: utilize as páginas do manual para conhecer mais sobre as funções
 usadas: man system man date
*/

int main(void) {
  char text[1024];

  FILE *fd = fopen("command.log", "a");
  if (fd == NULL) {
    perror("Error opening file!");
    return EXIT_FAILURE;
  }

  do {
    printf("Command: ");
    scanf("%1023[^\n]%*c", text);

    const time_t now = time(NULL);
    if (now == (time_t)(-1)) {
      perror("Failed to get time!");
      return EXIT_SUCCESS;
    }
    const struct tm *local_time = localtime(&now);
    if (local_time == NULL || (void *)local_time == (void *)&now) {
      perror("Failed to get calendar time!");
      return EXIT_SUCCESS;
    }

    /* system(const char *command) executes a command specified in command
        by calling /bin/sh -c command, and returns after the command has been
        completed.
    */
    if (strcmp(text, "end")) {
      printf("\n * Command to be executed: %s\n", text);
      fprintf(fd, "%02d:%02d: %s\n", local_time->tm_hour, local_time->tm_min,
              text);
      printf("---------------------------------\n");
      system(text);
      printf("---------------------------------\n");
    }
  } while (strcmp(text, "end"));

  printf("-----------The End---------------\n");

  fclose(fd);

  return EXIT_SUCCESS;
}
