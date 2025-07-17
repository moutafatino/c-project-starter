CC = gcc
CFLAGS = -pedantic-errors -Wall -Wextra -Wconversion -Wsign-conversion -Werror -Iinclude
SRCDIR = src
BUILDDIR = build
INCDIR = include
TARGET = app

SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(patsubst $(SRCDIR)/%.c,$(BUILDDIR)/%.o,$(SOURCES))

.PHONY: all clean compile_commands run post_run_cleanup

all: $(BUILDDIR) $(TARGET)

$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

$(TARGET): $(OBJECTS)
	@$(CC) $(OBJECTS) -o $(TARGET)

$(BUILDDIR)/%.o: $(SRCDIR)/%.c | $(BUILDDIR)
	@$(CC) $(CFLAGS) -c $< -o $@

compile_commands: compile_commands.json

compile_commands.json: $(SOURCES)
	@bear -- $(MAKE) clean $(TARGET)

# This is a new, separate target for cleaning up after run
post_run_cleanup:
	@rm -rf $(BUILDDIR) $(TARGET)

run: $(TARGET)
	@./$(TARGET)
	@$(MAKE) -s post_run_cleanup # Call the cleanup target after execution

clean:
	@rm -rf $(BUILDDIR) $(TARGET) compile_commands.json
