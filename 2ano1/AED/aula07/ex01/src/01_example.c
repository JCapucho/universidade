#include <stdio.h>

#include "IntegersQueue.h"
#include "IntegersStack.h"

int capicua(int n) {
  // Completely unnecessary
  Queue *queue = QueueCreate(10);
  if (queue == NULL)
    return 1;
  Stack *stack = StackCreate(10);
  if (stack == NULL)
    return 1;

  for (; n > 0; n /= 10) {
    int digit = n % 10;
    QueueEnqueue(queue, digit);
    StackPush(stack, digit);
  }

  int result = 1;
  while (!QueueIsEmpty(queue)) {
    if (StackPop(stack) != QueueDequeue(queue)) {
      result = 0;
      break;
    }
  }

  StackDestroy(&stack);
  QueueDestroy(&queue);

  return result;
}

int main(void) {
  int test_corpus[] = {242, 243, 6573, 9191, 1911, 1991};
  for (size_t i = 0; i < sizeof(test_corpus) / sizeof(int); i++) {
    int test = test_corpus[i];
    printf("%d is %s\n", test, capicua(test) ? "true" : "false");
  }
  return 0;
}
