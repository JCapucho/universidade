#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  int lower_limit = 0;
  int upper_limit = 100;

  if (argc == 3) {
    char *rest = NULL;
    lower_limit = strtol(argv[1], &rest, 10);
    if (rest != NULL && *rest != '\0') {
      fprintf(stderr, "ERROR: Not a valid number \"%s\"\n", argv[1]);
      return EXIT_FAILURE;
    }

    if (lower_limit < 0) {
      fprintf(stderr, "ERROR: Lower limit must be positive\n");
      return EXIT_FAILURE;
    }

    rest = NULL;
    upper_limit = strtol(argv[2], &rest, 10);
    if (rest != NULL && *rest != '\0') {
      fprintf(stderr, "ERROR: Not a valid number \"%s\"\n", argv[2]);
      return EXIT_FAILURE;
    }

    if (upper_limit < 0) {
      fprintf(stderr, "ERROR: Upper limit must be positive\n");
      return EXIT_FAILURE;
    }

    if (lower_limit >= upper_limit) {
      fprintf(stderr, "ERROR: Upper limit must be higher than lower limit\n");
      return EXIT_FAILURE;
    }
  } else if (argc != 1) {
    fprintf(stderr, "Error: Expected 0 or 2 arguments, got: %d\n", argc - 1);
    return EXIT_FAILURE;
  }

  int tentativas = 0;
  int alvo = (rand() + lower_limit) % upper_limit;

  while (1) {
    printf("Insert guess (e to exit): ");
    char *user_input = NULL;
    size_t user_input_alloc_size = 0;
    ssize_t result = getline(&user_input, &user_input_alloc_size, stdin);

    if (result < 0) {
      perror("ERROR");
      free(user_input);
      return EXIT_FAILURE;
    }

    if (user_input[result - 1] == '\n') {
      user_input[result - 1] = '\0';
      result--;
    }

    if (result == 1 && *user_input == 'e') {
      break;
    }

    char *rest = NULL;
    int guess = strtol(user_input, &rest, 10);
    if (rest != NULL && *rest != '\0') {
      fprintf(stderr, "ERROR: Not a valid number \"%s\"\n", user_input);
      continue;
    }

    free(user_input);
    tentativas++;

    if (guess == alvo) {
      printf("Acertou!\n");
      break;
    } else if (guess > alvo) {
      printf("Mais baixo\n");
    } else {
      printf("Mais alto\n");
    }
  }

  printf("Usou %d tentativas\n", tentativas);

  return EXIT_SUCCESS;
}
