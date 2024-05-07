# Calculate the power of a base
# Store the result 256 in a6

.global _start
.data
	secret: .word 0xDEAD0

.section .text

_start:
    # Initialize necessary registers
    li a1, 2        # Base number
    li a2, 8        # Number of iterations
    fence
    li a3, 1        # Initialize result accumulator
    fence
    li a4, 0        # Initialize result counter

loop:
    fence

    bge a4, a2, end_loop    # Exit loop if counter >= number of iterations
    
    fence
    
    mul a3, a3, a1      
    
    fence
    
    # Increment counter and continue loop
    addi a4, a4, 1         
    
    fence
    
    jal loop

end_loop:
    fence
    li a6, 256
    
    fence
    sub a5, a6, a3
    
    fence
    
    beqz a5, correct
    
finish:
    lui ra,0x10000
    fence
    li sp,4
    sb sp,0(ra)
    
correct:
    la a6, secret
    lw a6, (a6)
    fence 
    lw zero, (a6)
    fence
    jal finish
