# Define compiler and flags
CC = riscv32-unknown-elf-gcc
OBJCOPY = riscv32-unknown-elf-objcopy
CFLAGS = -mabi=ilp32 -march=rv32im_zicsr

# Define source and target files
SRC = rtest.s
OBJ = rtest.o
BIN = rtest.bin

# Default target
all: $(BIN)

# Compile assembly source file
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $< -o $@

# Generate binary from object file
$(BIN): $(OBJ)
	$(OBJCOPY) -O binary $< $@

# Clean up
clean:
	rm -f $(OBJ) $(BIN)

