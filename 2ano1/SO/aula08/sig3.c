#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#define NTIMES 50

static int sig_times = 0;

static void Interrupt(int);

int main(int argc, char *argv[]) {
  struct sigaction sigact;
  unsigned int i;

  /* altera a rotina de atendimento ao ^C */
  sigact.sa_handler = Interrupt;
  sigemptyset(&sigact.sa_mask);
  sigact.sa_flags = 0;
  if (sigaction(SIGINT, &sigact, NULL) < 0) {
    perror("Rotina de atendimento não instalada\n");
    return EXIT_FAILURE;
  }

  /* contador */
  printf("PID = %u\n", getpid());
  i = 0;
  while (i <= NTIMES) {
    printf("\r%08u ", i++);
    fflush(stdout);
    sleep(1);
  }
  printf("\n");

  return EXIT_SUCCESS;
}

static void Interrupt(int signum) {
  if (signum == SIGINT) {
    printf("\nCalma, ainda não cheguei a %d!\n", NTIMES);

    if (++sig_times == 4) {
      struct sigaction sigact;
      sigact.sa_handler = SIG_DFL;
      sigemptyset(&sigact.sa_mask);
      sigact.sa_flags = 0;
      if (sigaction(SIGINT, &sigact, NULL) < 0) {
        perror("Rotina de atendimento não instalada\n");
        exit(EXIT_FAILURE);
      }
    }
  } else {
    printf("Foi recebido um sinal diferente de SIGINT!\n");
    exit(EXIT_FAILURE);
  }
}
