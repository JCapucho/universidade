#include <stdio.h>

int main(void) {
  puts("Hello World!");          // Prints to stdout with newline
  printf("Hello World!");        // Prints to stdout no newline
  fputs("Hello World!", stdout); // Prints to a File no newline
  return 0;
}
