#include <stdio.h>

int main(void) {

  struct Test {
    char name[5];
    char test;
  } memory = {.test = 0x10};

  if (gets(memory.name) == NULL) {
    return 1;
  }

  printf("Hello %s\n", memory.name);
  printf("Test: 0x%x\n", memory.test);
  return 0;
}
