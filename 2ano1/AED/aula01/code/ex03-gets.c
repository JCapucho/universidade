#include <stdio.h>

int main(void) {
  char name[5];

  // So heavily deprecated the stdio.h header doesn't include a definition by
  // default, unless we compile with `-std=c99` which means we are using the
  // ISO C version from 1999.
  //
  // Really DON'T USE THIS, it's so broken beyond repair even the linker
  // throws warning messages.
  if (gets(name) == NULL) {
    return 1;
  }

  printf("Hello %s\n", name);
  return 0;
}
