#include <stdio.h>

int main(void) {
  char name[5];

  // Looks it's perfect it includes a size parameter to easily limit the
  // amount of data read and even allows selecting the file stream.
  if (fgets(name, 5, stdin) == NULL)
    return 1;

  printf("Hello %s\n", name);
  return 0;
}
