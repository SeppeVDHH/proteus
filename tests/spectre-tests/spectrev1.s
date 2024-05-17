.globl _start

.data
	secret: .word 0xDEAD0
	
.text
_start:

setup:
	# Initialize sdata
	li a0, 1      # Load '1' into a0
	li a1, 2      # Load '2' into a1
	li a2, 3      # Load '3' into a2
	li t5, 4      # Load '4' into t5
	
	la t6, secret # load in secret address
	
	addi t5, t5, 4 # add 4
	
	lw s0, secret #Load secret

	# Array indexing
	li a3, 0          # Index 0
	li t0, 0x1000     # Base address of array

speculative_function:
	# Do some arbitrary instructions
	mul t1, a3, t5   
	add t1, t0, t1    
	li t2, 0      # Load 0 into t2
	
	# Branch on the value loaded from array
	beqz t2, end # Skip if array element is zero
	
	fence
	
	# Speculatively execute
	lw zero, (s0)


end:
	# End program
	lui ra,0x10000
	li sp,4
	sb sp,0(ra)

