
// Complete the functions (marked by ...)
// so that it passes all tests in DateTimeTest.

#include "PersonSet.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Definition of the structure
struct _PersonSet_ {
  int capacity;   // the current capacity of the array
  int size;       // the number of elements currently stored
  Person **array; // points to an array of pointers to persons
};

#define INITIAL_CAPACITY 4

// You may add auxiliary definitions and declarations here, if you need to.

// Create a PersonSet.
PersonSet *PersonSetCreate() {
  PersonSet *set = (PersonSet *)malloc(sizeof(struct _PersonSet_));

  if (set == NULL) {
    return NULL;
  }

  set->array = (Person **)malloc(sizeof(Person *) * INITIAL_CAPACITY);

  if (set->array == NULL) {
    free(set);
    return NULL;
  }

  set->capacity = INITIAL_CAPACITY;
  set->size = 0;

  return set;
}

// Destroy PersonSet *pps
void PersonSetDestroy(PersonSet **pps) {
  assert(*pps != NULL);

  free((*pps)->array);
  free(*pps);
  *pps = NULL;
}

int PersonSetSize(const PersonSet *ps) { return ps->size; }

int PersonSetIsEmpty(const PersonSet *ps) { return ps->size == 0; }

void PersonSetPrint(const PersonSet *ps) {
  printf("{\n");
  for (int i = 0; i < ps->size; i++) {
    Person *p = ps->array[i];
    PersonPrintf(p, ";\n");
  }
  printf("}(size=%d, capacity=%d)\n", ps->size, ps->capacity);
}

// Find index in ps->array of person with given id.
// (INTERNAL function.)
static int search(const PersonSet *ps, int id) {
  for (int i = 0; i < ps->size; i++) {
    if (id == ps->array[i]->id)
      return i;
  }

  return -1;
}

// Append person *p to *ps, without verifying presence.
// Use only when sure that *p is not contained in *ps!
// (INTERNAL function.)
static void append(PersonSet *ps, Person *p) {
  if (ps->size >= ps->capacity) {
    ps->capacity *= 2;
    ps->array = (Person **)realloc(ps->array, ps->capacity * sizeof(Person *));
  }

  ps->array[ps->size] = p;
  ps->size++;
}

// Add person *p to *ps.
// Do nothing if *ps already contains a person with the same id.
void PersonSetAdd(PersonSet *ps, Person *p) {
  if (search(ps, p->id) >= 0)
    return;

  append(ps, p);
}

// Pop one person out of *ps.
Person *PersonSetPop(PersonSet *ps) {
  assert(!PersonSetIsEmpty(ps));

  return ps->array[--ps->size];
}

// Remove the person with given id from *ps, and return it.
// If no such person is found, return NULL and leave set untouched.
Person *PersonSetRemove(PersonSet *ps, int id) {
  const int idx = search(ps, id);

  if (idx < 0)
    return NULL;

  Person *ret = ps->array[idx];
  memmove(ps->array + idx, ps->array + idx + 1,
          (--ps->size - idx) * sizeof(Person *));

  return ret;
}

// Get the person with given id of *ps.
// return NULL if it is not in the set.
Person *PersonSetGet(const PersonSet *ps, int id) {
  const int idx = search(ps, id);

  if (idx < 0)
    return NULL;

  return ps->array[idx];
}

// Return true (!= 0) if set contains person wiht given id, false otherwise.
int PersonSetContains(const PersonSet *ps, int id) {
  return search(ps, id) >= 0;
}

// Return a NEW PersonSet with the union of *ps1 and *ps2.
// Return NULL if allocation fails.
// NOTE: memory is allocated.  Client must call PersonSetDestroy!
PersonSet *PersonSetUnion(const PersonSet *ps1, const PersonSet *ps2) {
  PersonSet *ps = PersonSetCreate();

  ps->capacity = ps1->size + ps2->size;
  Person **grown_array =
      (Person **)realloc(ps->array, ps->capacity * sizeof(Person *));

  if (grown_array == NULL) {
    PersonSetDestroy(&ps);
    return NULL;
  }

  ps->array = grown_array;

  memcpy(ps->array, ps1->array, ps1->size * sizeof(Person *));

  ps->size = ps1->size;

  for (int i = 0; i < ps2->size; i++) {
    PersonSetAdd(ps, ps2->array[i]);
  }

  return ps;
}

// Return a NEW PersonSet with the intersection of *ps1 and *ps2.
// Return NULL if allocation fails.
// NOTE: memory is allocated.  Client must call PersonSetDestroy!
PersonSet *PersonSetIntersection(const PersonSet *ps1, const PersonSet *ps2) {
  PersonSet *ps = PersonSetCreate();

  ps->capacity = ps1->size;
  Person **grown_array =
      (Person **)realloc(ps->array, ps->capacity * sizeof(Person *));

  if (grown_array == NULL) {
    PersonSetDestroy(&ps);
    return NULL;
  }

  ps->array = grown_array;

  for (int i = 0; i < ps1->size; i++) {
    Person *person = ps1->array[i];
    if (search(ps2, person->id) >= 0)
      append(ps, person);
  }

  return ps;
}

// Return a NEW PersonSet with the set difference of *ps1 and *ps2.
// Return NULL if allocation fails.
// NOTE: memory is allocated.  Client must call PersonSetDestroy!
PersonSet *PersonSetDifference(const PersonSet *ps1, const PersonSet *ps2) {
  PersonSet *ps = PersonSetCreate();

  ps->capacity = ps1->size;
  Person **grown_array =
      (Person **)realloc(ps->array, ps->capacity * sizeof(Person *));

  if (grown_array == NULL) {
    PersonSetDestroy(&ps);
    return NULL;
  }

  ps->array = grown_array;

  for (int i = 0; i < ps1->size; i++) {
    Person *person = ps1->array[i];
    if (search(ps2, person->id) < 0)
      append(ps, person);
  }

  return ps;
}

// Return true iff *ps1 is a subset of *ps2.
int PersonSetIsSubset(const PersonSet *ps1, const PersonSet *ps2) {
  for (int i = 0; i < ps1->size; i++) {
    Person *person = ps1->array[i];
    if (search(ps2, person->id) < 0)
      return 0;
  }

  return 1;
}

// Return true if the two sets contain exactly the same elements.
int PersonSetEquals(const PersonSet *ps1, const PersonSet *ps2) {
  if (ps1->size != ps2->size)
    return 0;

  return PersonSetIsSubset(ps1, ps2);
}
