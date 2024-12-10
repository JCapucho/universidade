SRC_DIR = src
BUILD_DIR = build
OBJS_DIR = $(BUILD_DIR)/objs

TARGET = Ex03
LIBS = -lm
CC = gcc
CFLAGS = -g -Wextra -Wall -Werror -Wpedantic -std=c11

.PHONY: default all clean

default: run 
all: default

OBJECTS = $(patsubst $(SRC_DIR)/%.c, $(OBJS_DIR)/%.o, $(wildcard $(SRC_DIR)/*.c))
HEADERS = $(wildcard $(SRC_DIR)/*.h)

$(OBJS_DIR):
	mkdir -p $(OBJS_DIR)

$(BUILD_DIR):
	mkdir -p $(OBJS_DIR)

$(OBJS_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS) $(OBJS_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS) $(BUILD_DIR)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $(BUILD_DIR)/$@

run: $(TARGET)
	$(BUILD_DIR)/$(TARGET)

valgrind: $(TARGET)
	valgrind $(BUILD_DIR)/$(TARGET)

clean:
	-rm -f *.o
	-rm -f $(TARGET)
