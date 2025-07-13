CC = gcc
CFLAGS = -pedantic-errors -Wall -Wextra -Wconversion -Wsign-conversion -Werror -Iinclude
SRCDIR = src
INCDIR = include
TARGET = app

SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(SOURCES:.c=.o)

.PHONY: all clean compile_commands

all: $(TARGET)

$(TARGET): $(OBJECTS)
	@$(CC) $(OBJECTS) -o $(TARGET)

$(SRCDIR)/%.o: $(SRCDIR)/%.c
	@$(CC) $(CFLAGS) -c $< -o $@

compile_commands: compile_commands.json

compile_commands.json: $(SOURCES)
	@bear -- $(MAKE) clean $(TARGET)

clean:
	@rm -f $(OBJECTS) $(TARGET) compile_commands.json

run: $(TARGET)
	@./$(TARGET)
	@rm -f $(TARGET)
