# rtest.s - Simple RISC-V assembly program to add 2 and 3 and subtract 4

.global _start

.section .text

_start:
    # Load immediate values into registers
    li a0, 2        # Load immediate 2 into register a0
    li a1, 3        # Load immediate 3 into register a1
    li a2, 4        # Load immediate 4 into register a2

    # Add 2 and 3
    add a3, a0, a1  # Add the contents of a0 and a1, store result in a3
    
    fence
    
    # Subtract 4 from the result of addition
    sub a3, a3, a2  # Subtract the contents of a2 from a3, store result in a3
    
    # Exit the program
    lui ra,0x10000
    li sp,4
    sb sp,0(ra)
