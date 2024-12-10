#include <stdio.h>

#include "Date.h"
#include "Person.h"

#include "PointersQueue.h"
#include "PointersStack.h"

int main(void) {
  Queue *person_queue = QueueCreate(10);
  if (person_queue == NULL)
    return 1;
  Stack *date_stack = StackCreate(10);
  if (date_stack == NULL)
    return 1;

  for (int i = 0; i < 10; i++) {
    Person *person = PersonCreate("fname", "lname", 1991, 9, i + 1);
    if (person == NULL)
      return 1;

    QueueEnqueue(person_queue, person);

    Date *date = DateCreate(1991, 9, i + 1);
    if (date == NULL)
      return 1;

    StackPush(date_stack, date);
  }

  while (!QueueIsEmpty(person_queue)) {
    Person *person = (Person *)QueueDequeue(person_queue);
    PersonPrintf(person, "\n");
    PersonDestroy(&person);
  }

  while (!StackIsEmpty(date_stack)) {
    Date *date = (Date *)StackPop(date_stack);
    printf("%s\n", DateFormat(date, DMY));
    DateDestroy(&date);
  }

  QueueDestroy(&person_queue);
  StackDestroy(&date_stack);

  return 0;
}
