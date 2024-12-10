CC = gcc

CFLAGS = -Wall

LDFLAGS = -lm

.PHONY: all clean cleanall

all: reg-cri

reg-cri:	sharedMemory.o reg-cri.o
	gcc ${CFLAGS} -o $@ $^ ${LDFLAGS}

reg-cri.o:	sharedMemory.h

reg-cri-correct:	sharedMemory.o semaphore.o reg-cri-correct.o
	gcc ${CFLAGS} -o $@ $^ ${LDFLAGS}

reg-cri-correct.o:	sharedMemory.h semaphore.h

clean:
	rm -f *.o *~

cleanall:	clean
	rm -f reg-cri

