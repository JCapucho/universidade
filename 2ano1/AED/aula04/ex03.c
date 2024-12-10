#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int check_condition(float *arr, size_t length, int *num_comps) {
  if (length < 3)
    return 0;

  int conforms = 0;

  for (size_t i = 0; i < length; i++) {
    for (size_t j = i + 1; j < length; j++) {
      for (size_t k = j + 1; k < length; k++) {
        *num_comps += 1;
        if (arr[k] == arr[i] + arr[j])
          conforms += 1;
      }
    }
  }

  return conforms;
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
    int num_comps = 0;
    int resultado = check_condition(test_array[test], 10, &num_comps);

    print_array(test_array[test], 10);
    printf("\tResultado: %d", resultado);
    printf("\tN° de comparações: %d\n", num_comps);
  }

  return 0;
}
