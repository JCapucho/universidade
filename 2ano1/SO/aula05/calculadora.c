#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  if (argc != 4) {
    fprintf(stderr, "ERROR: Expected 3 arguments got %d\n", argc - 1);
    return EXIT_FAILURE;
  }

  const float left = atof(argv[1]);
  const float right = atof(argv[3]);

  const char *op = argv[2];
  if (strlen(op) != 1) {
    fprintf(stderr, "ERROR: Unknown operation \"%s\"\n", op);
    return EXIT_FAILURE;
  }

  float result;

  switch (*op) {
  case '+':
    result = left + right;
    break;
  case '-':
    result = left - right;
    break;
  case 'x':
    result = left * right;
    break;
  case '/':
    result = left / right;
    break;
  case 'p':
    result = pow(left, right);
    break;
  default:
    fprintf(stderr, "ERROR: Unknown operation \"%s\"\n", op);
    return EXIT_FAILURE;
  }

  printf("%f %s %f = %f\n", left, op, right, result);

  return EXIT_SUCCESS;
}
