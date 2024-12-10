#include <math.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// The coefficients of a degree n polynomial
// are stored in an array p of size (n + 1)
// p[0] is the coefficient of the largest degree term
// p[n] is the coefficient of the zero-degree term
// Display a polynomial
// Pre-Conditions: coef != NULL and degree >= 0
// Example of produced output:
// Pol(x) = 1.000000 * x^2 + 4.000000 * x^1 + 1.000000
void DisplayPol(double *coef, size_t degree) {
  printf("Pol(x) = ");

  for (size_t i = 0; i < degree + 1; i++) {
    if (i != 0)
      printf(" + ");

    printf("%lf", coef[i]);

    if (i != degree)
      printf(" * x^%lu", degree - i);
  }

  putchar('\n');
}

// Compute the value of a polynomial using Horner’s method:
// Pre-Conditions: coef != NULL and degree >= 0
double ComputePol(double *coef, size_t degree, double x) {
  double a = coef[0];

  for (size_t i = 1; i < degree + 1; i++) {
    a = coef[i] + x * a;
  }

  return a;
}

// Test example:
// Pol(x) = 1.000000 * x^2 + 4.000000 * x^1 + 1.000000
// Pol(2.000000) = 13.000000
// Compute the real roots, if any, of a second-degree polynomial
// Pre-Conditions: coef != NULL and degree == 2 and coef[0] != 0
// Pre-Conditions: root_1 != NULL and root_2 != NULL
// Return values: 0 -> no real roots
//                1 -> 1 real root with multiplicity 2
//                2 -> 2 distinct real roots
// The computed root values are returned via the root_1 and root_2
// pointer arguments
// Assign 0.0 to the *root_1 and *root_2 if there are no real roots
unsigned int GetRealRoots(double *coef, size_t degree, double *root_1,
                          double *root_2) {
  if (degree != 2) {
    *root_1 = 0.0;
    *root_2 = 0.0;
    return 0;
  }

  const double a = coef[0], b = coef[1], c = coef[2];
  const double inner_root = b * b - 4 * a * c;

  if (inner_root < 0.0) {
    *root_1 = 0.0;
    *root_2 = 0.0;
    return 0;
  }

  *root_1 = (-b + sqrt(inner_root)) / (2 * a);
  *root_2 = (-b - sqrt(inner_root)) / (2 * a);

  if (*root_1 == *root_2)
    return 1;

  return 2;
}

int main(void) {
  double coefs[] = {2, 1, -6};
  const size_t degree = (sizeof(coefs) / sizeof(double)) - 1;

  DisplayPol(coefs, degree);

  const double res = ComputePol(coefs, degree, 1.0);

  printf("P(1) = %lf\n", res);

  double root_1 = 0.0, root_2 = 0.0;

  const unsigned int roots = GetRealRoots(coefs, degree, &root_1, &root_2);

  printf("Roots: %u\n", roots);
  printf("First root: %lf\n", root_1);
  printf("Second root: %lf\n", root_2);
}
