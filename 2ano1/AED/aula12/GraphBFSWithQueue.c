//
// Algoritmos e Estruturas de Dados --- 2023/2024
//
// Joaquim Madeira, Joao Manuel Rodrigues - June 2021, Nov 2023
//
// GraphBFS - QUEUE-based Breadth-First Search
//

#include "GraphBFSWithQueue.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "Graph.h"
#include "IntegersQueue.h"
#include "IntegersStack.h"

struct _GraphBFSWithQueue {
  int *marked;      // To mark vertices when reached for the first time
  int *distance;    // The number of edges on the path from the start vertex
  int *predecessor; // The predecessor vertex, when a vertex was reached
  Graph *graph;
  unsigned int startVertex;
};

GraphBFSWithQueue *GraphBFSWithQueueExecute(Graph *g,
                                            unsigned int startVertex) {
  assert(g != NULL);
  assert(startVertex < GraphGetNumVertices(g));

  GraphBFSWithQueue *traversal =
      (GraphBFSWithQueue *)malloc(sizeof(struct _GraphBFSWithQueue));
  assert(traversal != NULL);

  unsigned int numVertices = GraphGetNumVertices(g);

  traversal->marked = (int *)calloc(numVertices, sizeof(unsigned int));
  assert(traversal->marked != NULL);

  traversal->predecessor = (int *)malloc(numVertices * sizeof(int));
  assert(traversal->predecessor != NULL);
  for (unsigned int i = 0; i < numVertices; i++) {
    traversal->predecessor[i] = -1;
  }

  traversal->distance = (int *)malloc(numVertices * sizeof(int));
  assert(traversal->distance != NULL);
  for (unsigned int i = 0; i < numVertices; i++) {
    traversal->distance[i] = -1;
  }

  traversal->graph = g;
  traversal->startVertex = startVertex;

  // CARRY OUT THE TRAVERSAL
  Queue *to_visit = QueueCreate(numVertices);

  QueueEnqueue(to_visit, startVertex);
  traversal->predecessor[startVertex] = 0;
  traversal->distance[startVertex] = 0;

  while (!QueueIsEmpty(to_visit)) {
    unsigned int vertex = QueueDequeue(to_visit);

    traversal->marked[vertex] = 1;

    unsigned int this_distance = traversal->distance[vertex];

    unsigned int *neighbors = GraphGetAdjacentsTo(traversal->graph, vertex);

    for (unsigned int i = 1; i <= neighbors[0]; i++) {
      unsigned int w = neighbors[i];
      if (traversal->marked[w] == 0) {
        traversal->predecessor[w] = vertex;
        traversal->distance[w] = this_distance + 1;
        QueueEnqueue(to_visit, w);
      }
    }

    free(neighbors);
  }

  QueueDestroy(&to_visit);

  return traversal;
}

void GraphBFSWithQueueDestroy(GraphBFSWithQueue **p) {
  assert(*p != NULL);

  GraphBFSWithQueue *aux = *p;

  free(aux->marked);
  free(aux->predecessor);

  free(*p);
  *p = NULL;
}

// Getting the result

int GraphBFSWithQueueHasPathTo(const GraphBFSWithQueue *p, unsigned int v) {
  assert(p != NULL);
  assert(v < GraphGetNumVertices(p->graph));

  return p->marked[v];
}

Stack *GraphBFSWithQueuePathTo(const GraphBFSWithQueue *p, unsigned int v) {
  assert(p != NULL);
  assert(v < GraphGetNumVertices(p->graph));

  Stack *s = StackCreate(GraphGetNumVertices(p->graph));

  if (p->marked[v] == 0) {
    return s;
  }

  // Store the path
  for (unsigned int current = v; current != p->startVertex;
       current = p->predecessor[current]) {
    StackPush(s, current);
  }

  StackPush(s, p->startVertex);

  return s;
}

// DISPLAYING on the console

void GraphBFSWithQueueShowPath(const GraphBFSWithQueue *p, unsigned int v) {
  assert(p != NULL);
  assert(v < GraphGetNumVertices(p->graph));

  Stack *s = GraphBFSWithQueuePathTo(p, v);

  while (StackIsEmpty(s) == 0) {
    printf("%d ", StackPop(s));
  }

  StackDestroy(&s);
}

void GraphBFSWithQueueDisplay(const GraphBFSWithQueue *p) {
  assert(p != NULL);

  // TO BE COMPLETED !!
}
