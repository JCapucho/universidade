#include <stdio.h>

static size_t NUM_ADICOES = 0;

// Perdemos precisão antes de se tornar muito demoroso
unsigned long long int Delannoy(unsigned int m, unsigned int n) {
  unsigned long long int lut[m + 1][n + 1];

  for (unsigned long long int j = 0; j <= n; j++) {
    lut[0][j] = 1;
  }

  for (unsigned int i = 1; i <= m; i++) {
    lut[i][0] = 1;
    for (unsigned int j = 1; j <= n; j++) {
      NUM_ADICOES += 2;
      lut[i][j] = lut[i - 1][j] + lut[i - 1][j - 1] + lut[i][j - 1];
    }
  }

  return lut[m][n];
}

int main(void) {
  unsigned int max_k;
  printf("Calcular até: ");
  if (scanf("%u", &max_k) != 1)
    return 1;

  FILE *stats = fopen("cache_stats.txt", "w");

  if (stats == NULL) {
    perror("Error opening file");
    return 1;
  }

  printf("Delannoy's Matrix - Cached Function\n");
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
