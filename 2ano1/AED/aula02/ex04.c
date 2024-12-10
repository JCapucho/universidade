#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Display the contents of array a with n elements
// Pre-Conditions: a != NULL and n > 0
// Example of produced output: Array = [ 1.00, 2.00, 3.00 ]
void DisplayArray(double *a, size_t n) {
  printf("Array = [");

  for (size_t i = 0; i < n; i++)
    printf(" %.2lf", a[i]);

  printf(" ]\n");
}

// Read the number of elements, allocate the array and read its elements
// Condition: number of elements > 0
// Pre-Condition: size_p != NULL
// Return NULL if memory allocation fails
// Set *size_p to ZERO if memory allocation fails
double *ReadArray(size_t *size_p) {
  printf("Número de elementos: ");

  if (scanf(" %lu", size_p) != 1) {
    *size_p = 0;
    return NULL;
  }

  double *result = malloc(*size_p * sizeof(double));

  if (result == NULL) {
    *size_p = 0;
    return NULL;
  }

  size_t read = 0;
  while (read != *size_p) {
    printf("%lu: ", read);

    if (scanf(" %lf", &result[read]) != 1)
      printf("Please insert again\n");
    else
      read++;
  }

  return result;
}

// Allocate and return a new array with (size_1 + size_2) elements
// which stores the elements of array_1 followed by the elements of array_2
// Pre-Conditions: array_1 != NULL and array_2 != NULL
// Pre-Conditions: size_1 > 0 and size_2 > 0
// Return NULL if memory allocation fails
double *Append(double *array_1, size_t size_1, double *array_2, size_t size_2) {
  double *result = malloc(sizeof(double) * (size_1 + size_2));

  if (result == NULL)
    return NULL;

  memcpy(result, array_1, size_1 * sizeof(double));
  memcpy(result + size_1, array_2, size_2 * sizeof(double));

  return result;
}

// Test example:
//
//
// Array = [ 1.00, 2.00, 3.00 ]
// Array = [ 4.00, 5.00, 6.00, 7.00 ]
// Array = [ 1.00, 2.00, 3.00, 4.00, 5.00, 6.00, 7.00 ]
//
//

int main(void) {
  size_t array_size = 0;
  double *array = ReadArray(&array_size);

  if (array == NULL)
    return 1;

  DisplayArray(array, array_size);

  size_t array2_size = 0;
  double *array2 = ReadArray(&array2_size);

  if (array2 == NULL)
    return 1;

  double *append = Append(array, array_size, array2, array2_size);

  if (append == NULL)
    return 1;

  DisplayArray(append, array_size + array2_size);

  free(append);
  free(array2);
  free(array);

  return 0;
}
