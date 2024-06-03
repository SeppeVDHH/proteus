.globl _start
.data
	var1: .word 0
	var2: .word 0
	secret: .word 0xDEAD0
.text
_start:

main:
	la t3, secret
	lw t0, (t0)
	lw t0, (t0)
	# Load values from memory into registers
	li t0, 1        # Load value of var1 into register t0
	li t1, 1        # Load value of var2 into register t1
	    
	
	fence
	# Compare the values in registers
	beq t0, t1, finish   # Branch to equal label if t0 equals t1
	lw t3, (t3)
	lw zero, (t3)

finish:
	lui ra,0x10000
	li sp,4
	sb sp,0(ra)

