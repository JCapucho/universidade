#include <stddef.h>
#include <stdio.h>

int main(void) {
  char name[5];

  if (fgets(name, sizeof(name), stdin) == NULL)
    return 1;

  for (size_t i = 0; i < sizeof(name); i++) {
    if (name[i] == '\0')
      break;

    if (name[i] == '\n') {
      name[i] = '\0';
      break;
    }
  }

  printf("Hello %s\n", name);
  return 0;
}
