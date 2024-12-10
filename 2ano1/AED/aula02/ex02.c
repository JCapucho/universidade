#include <ctype.h>
#include <stdio.h>
#include <string.h>

#define INPUT_SIZE 200

void lowerAll(char *str) {
  for (size_t i = 0; str[i] != '\0'; i++)
    str[i] = tolower(str[i]);
}

int readLine(char *str, const size_t size) {
  if (fgets(str, size, stdin) == NULL)
    return -1;

  str[strcspn(str, "\n")] = '\0';

  return 0;
}

int main(void) {
  char str1[INPUT_SIZE];
  char str2[INPUT_SIZE * 2];

  printf("Insert first string: ");
  if (readLine(str1, INPUT_SIZE) != 0)
    return 1;

  printf("Insert second string: ");
  if (readLine(str2, INPUT_SIZE) != 0)
    return 1;

  unsigned int numAlpha = 0;
  for (int i = 0; str1[i] != '\0'; i++) {
    if (isalpha(str1[i]))
      numAlpha++;
  }
  printf("Caracteres do alfabeto =  %d\n", numAlpha);

  unsigned int numUpperCase = 0;
  for (int i = 0; str2[i] != '\0'; i++) {
    if (isupper(str2[i]))
      numUpperCase++;
  }
  printf("Caracteres maisculos =  %d\n", numUpperCase);

  lowerAll(str1);
  printf("First string minusculas =  %s\n", str1);
  lowerAll(str2);
  printf("Second string minusculas =  %s\n", str2);

  int cmpRes = strcmp(str1, str2);

  if (cmpRes == 0) {
    printf("As strings são iguais\n");
  } else if (cmpRes > 0) {
    puts(str2);
    puts(str1);
  } else {
    puts(str1);
    puts(str2);
  }

  char str3[INPUT_SIZE];

  strcpy(str3, str2);
  printf("Cópia da segunda string: %s\n", str3);

  strcat(str2, str3);
  printf("Strings concatenadas: %s\n", str2);

  return 0;
}
