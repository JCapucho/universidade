#include <math.h>
#include <stdio.h>

int main(void) {
  float a;

  if (scanf("%f", &a) != 1)
    return 1;

  float result = sqrt(a);
  printf("%f\n", result);
  return 0;
}
