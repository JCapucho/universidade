#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

/* SUGESTÂO: utilize as páginas do manual para conhecer mais sobre as funções
  usadas: man opendir man readdir
*/

void listDir(char dirname[]) {
  DIR *dp;
  struct dirent *dent;

  dp = opendir(dirname);
  if (dp == NULL) {
    perror("Error opening directory");
    return;
  }

  dent = readdir(dp);
  while (dent != NULL) {
    if (dent->d_name[0] != '.') /* do not list hidden dirs/files */
    {
      struct stat path_stat;
      if (stat(dent->d_name, &path_stat) != 0) {
        perror("Error executing stat");
        return;
      }

      char type = ' ';
      if S_ISDIR (path_stat.st_mode)
        type = 'd';

      printf("%c %s/%s\n", type, dirname, dent->d_name);

      if S_ISDIR (path_stat.st_mode) {
        // Size of the two plus null byte and slash
        size_t child_dirname_size = strlen(dirname) + strlen(dent->d_name) + 2;
        char *child_dirname = (char *)malloc(sizeof(char) * child_dirname_size);
        if (child_dirname == NULL) {
          perror("Error allocating memory");
          return;
        }

        sprintf(child_dirname, "%s/%s", dirname, dent->d_name);

        listDir(child_dirname);

        free(child_dirname);
      }
    }

    dent = readdir(dp);
  }
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf(stderr, "Usage: %s base_directory\n", argv[0]);
    return EXIT_FAILURE;
  }

  listDir(argv[1]);

  return EXIT_SUCCESS;
}
