#!/bin/bash

# Execute the make command with specified options
make -C tests CORE=riscv.CoreDynamicExtMem RISCV_PREFIX=riscv32-unknown-elf
