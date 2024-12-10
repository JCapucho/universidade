#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int check_condition(int *arr, size_t length, int *num_comps) {
  int conforms = 0;

  for (size_t i = 1; i < length - 1; i++) {
    *num_comps += 1;
    if (arr[i] == arr[i - 1] + arr[i + 1])
      conforms += 1;
  }

  return conforms;
}

void print_array(int *arr, size_t length) {
  for (size_t i = 0; i < length - 1; i++) {
    printf("%d, ", arr[i]);
  }

  if (length > 0)
    printf("%d", arr[length - 1]);
}

int main(void) {
  int test_array[5][10] = {
      {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 1, 4, 5, 6, 7, 8, 9, 10},
      {1, 2, 1, 3, 2, 6, 7, 8, 9, 10}, {0, 2, 2, 0, 3, 3, 0, 4, 4, 0},
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  };

  for (int test = 0; test < 5; test++) {
    int num_comps = 0;
    int resultado = check_condition(test_array[test], 10, &num_comps);

    print_array(test_array[test], 10);
    printf("\tResultado: %d", resultado);
    printf("\tN° de comparações: %d\n", num_comps);
  }

  return 0;
}
