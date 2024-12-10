#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int check_condition(float *arr, size_t length, int *num_ops) {
  if (length < 3)
    return 0;

  float r = arr[1] / arr[0];
  *num_ops += 1;

  for (size_t i = 2; i < length; i++) {
    *num_ops += 1;
    if (arr[i] != r * arr[i - 1])
      return 0;
  }

  return 1;
}

void print_array(float *arr, size_t length) {
  for (size_t i = 0; i < length - 1; i++) {
    printf("%.1f, ", arr[i]);
  }

  if (length > 0)
    printf("%.1f", arr[length - 1]);
}

int main(void) {
  float test_array[9][10] = {
      {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
      {1, 2, 4, 4, 5, 6, 7, 8, 9, 10},
      {1, 2, 4, 8, 5, 6, 7, 8, 9, 10},
      {1, 2, 4, 8, 16, 6, 7, 8, 9, 10},
      {1, 2, 4, 8, 16, 32, 7, 8, 9, 10},
      {1, 2, 4, 8, 16, 32, 64, 8, 9, 10},
      {1, 2, 4, 8, 16, 32, 64, 128, 9, 10},
      {1, 2, 4, 8, 16, 32, 64, 128, 256, 10},
      {1, 2, 4, 8, 16, 32, 64, 128, 256, 512},

  };

  for (int test = 0; test < 9; test++) {
    int num_ops = 0;
    int resultado = check_condition(test_array[test], 10, &num_ops);

    print_array(test_array[test], 10);
    printf("\tResultado: %d", resultado);
    printf("\tN° de operações: %d\n", num_ops);
  }

  return 0;
}
