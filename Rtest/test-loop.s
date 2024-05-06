# Assume a4 initially holds 0
# Calculate 2^0 + 2^1 + 2^2 + ... + 2^7 = 255
# Store the result 255 in a4

.global _start
.data
	secret: .word 0xDEAD0

.section .text

_start:
    # Initialize necessary registers
    li a1, 1        # Base number
    li a2, 8        # Number of iterations
    li a3, 0        # Initialize result accumulator
    li a4, 0        # Initialize result counter

loop:
    bge a4, a2, end_loop    # Exit loop if counter >= number of iterations
    
    # Calculate power of 2 and add to result accumulator
    slli a5, a1, 0(a4)      # Shift left by the value in a4
    add a3, a3, a5         # Accumulate result
    
    # Increment counter and continue loop
    addi a4, a4, 1          # Increment counter
    j loop

end_loop:
    li a6, 255
    
    sub a5, a6, a3
    
    beqz a5, correct
    
finish:
    lui ra,0x10000
    li sp,4
    sb sp,0(ra)
    
correct:
    la a6, secret
    lw a6, (a6)
    lw zero, (a6)
    jal finish
