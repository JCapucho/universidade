#define _POSIX_C_SOURCE 200809

#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>

int main(void) {
  char *name = NULL;
  size_t alloc_size;

  ssize_t size = getline(&name, &alloc_size, stdin);

  if (size == -1) {
    return 1;
  }

  if (name[size - 1] == '\n') {
	  name[size - 1] = '\0';
  }

  printf("Hello %s!\n", name);
  free(name);
  return 0;
}
