# Program to calculate Fibonacci sequence up to a certain number

.global _start
.data
	secret: .word 0xDEAD0

.section .text

_start:
    # Initialize variables
    li  a7, 10          # Set a0 to 10 (number of Fibonacci numbers to generate)
    li  a0, 0           # Initialize first Fibonacci number (0)
    li  a1, 1           # Initialize second Fibonacci number (1)
    
    fence
    
    li  a2, 0           # Initialize loop counter
    
loop:
    
    # Calculate next Fibonacci number
    add a3, a0, a1      # a3 = a0 + a1
    mv  a0, a1          # a0 = a1
    mv  a1, a3          # a1 = a3
    
    fence
    
    # Increment loop counter
    
    fence
    addi a2, a2, 1      # Increment loop counter
    
    fence
    
    # Check if reached desired number of Fibonacci numbers
    blt a2, a7, loop    # Branch to loop if t2 < a7
    
    fence
    
    li a6, 89
    
    sub a6, a6, a1
    
    fence 

    beqz a6, correct
    
finish:
    fence
    lui ra,0x10000
    li sp,4
    sb sp,0(ra)
    
correct:
    la a6, secret
    lw a6, (a6)
    lw zero, (a6)
    jal finish
