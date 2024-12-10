#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  if (argc != 4) {
    fprintf(stderr, "ERROR: Expected 3 arguments got %d\n", argc - 1);
    return EXIT_FAILURE;
  }

  char *rest = NULL;
  const float left = strtod(argv[1], &rest);
  if (rest != NULL && strlen(rest) != 0) {
    fprintf(stderr, "ERROR: Not a valid number \"%s\"\n", argv[1]);
    return EXIT_FAILURE;
  }

  rest = NULL;
  const float right = strtod(argv[3], &rest);
  if (rest != NULL && strlen(rest) != 0) {
    fprintf(stderr, "ERROR: Not a valid number \"%s\"\n", argv[3]);
    return EXIT_FAILURE;
  }

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
