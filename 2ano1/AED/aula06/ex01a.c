#include <stdio.h>

static size_t NUM_ADICOES = 0;

// k = 13, 2s
unsigned long long int Delannoy(int m, int n) {
  if (m == 0 || n == 0)
    return 1;

  NUM_ADICOES += 2;
  return Delannoy(m - 1, n) + Delannoy(m - 1, n - 1) + Delannoy(m, n - 1);
}

int main(void) {
  unsigned int max_k;
  printf("Calcular até: ");
  if (scanf("%u", &max_k) != 1)
    return 1;

  FILE *stats = fopen("recursive_stats.txt", "w");

  if (stats == NULL) {
    perror("Error opening file");
    return 1;
  }

  printf("Delannoy's Matrix - Recursive Function\n");
  for (unsigned int m = 0; m <= max_k; m++) {
    for (unsigned int n = 0; n <= max_k; n++) {
      NUM_ADICOES = 0;
      unsigned long long int f1_res = Delannoy(m, n);
      printf("%-7llu ", f1_res);

      fprintf(stats, "D(%u, %u) = %llu (Adições = %lu)\n", m, n, f1_res,
              NUM_ADICOES);
    }
    printf("\n");
  }

  fclose(stats);

  return 0;
}
