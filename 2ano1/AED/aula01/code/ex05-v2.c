#include <math.h>
#include <stdio.h>
#include <string.h>

#define M_PI 3.14159265358979323846

int max(int a, int b) { return a >= b ? a : b; }

int main(void) {
  int angle_precision = 1;
  int precision = 4;

  float start_angle;
  float end_angle;
  float step_angle;

  printf("Angulo inicial: ");
  if (scanf("%f", &start_angle) != 1)
    return 1;

  printf("Angulo final: ");
  if (scanf("%f", &end_angle) != 1)
    return 1;

  printf("Passo: ");
  if (scanf("%f", &step_angle) != 1)
    return 1;

  // Cabeçalhos
  char *angle_header = "ang";
  char *sin_header = "sin (ang)";
  char *cos_header = "cos (ang)";

  // Tamanho máximo dos números nas colunas.
  int start_angle_width =
      snprintf(NULL, 0, "%.*f", angle_precision, fabs(start_angle));
  int end_angle_width =
      snprintf(NULL, 0, "%.*f", angle_precision, fabs(end_angle));
  // Mais 1 para o sinal
  int angle_width = max(start_angle_width, end_angle_width) + 1;
  // 3 caracteres para a parte inteira e o ponto e o sinal
  int trig_res_width = 3 + precision;

  // Tamanho das colunas
  int first_column_size = max(angle_width, strlen(angle_header));
  int second_column_size = max(trig_res_width, strlen(sin_header));
  int third_column_size = max(trig_res_width, strlen(cos_header));

  // Imprimir o cabeçalho
  printf("%-*s %-*s %-*s\n", first_column_size, angle_header,
         second_column_size, sin_header, third_column_size, cos_header);

  float current_angle = start_angle;

  // Imprimir o separador
  for (int i = 0; i < first_column_size; i++)
    putchar('-');

  putchar(' ');

  for (int i = 0; i < second_column_size; i++)
    putchar('-');

  putchar(' ');

  for (int i = 0; i < third_column_size; i++)
    putchar('-');

  putchar('\n');

  // Imprimir as linhas
  while (1) {
    float angle_radians = current_angle * M_PI / 180;

    printf("%*.*f %*.*f %*.*f\n",
           /* Angle */
           first_column_size, angle_precision, current_angle,
           /* Sine */
           second_column_size, precision, sin(angle_radians),
           /* Cossine */
           third_column_size, precision, cos(angle_radians));

    current_angle += step_angle;

    if (current_angle > end_angle)
      break;
  }

  return 0;
}
