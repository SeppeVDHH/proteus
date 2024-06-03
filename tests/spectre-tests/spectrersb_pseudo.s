.globl _start

.data
	target1: .word handler1
	target2: .word handler2
	secret: .word 0xDEAD0

.text

_start:
	# Load the address of target1 into register t0
	la t0, target1
	# Load the address stored at target1 into t1
	lw t1, 0(t0)
    
	lw s0, secret #Load secret
	
	# Indirect jump to the address in t1
	fence 
	jalr x0, t1, 0   #RET pseudo instruction

handler1:
	# This is where we land if we jump to handler1
	# Do some work here
	li a0, 1       	# Load 1 into a0 to indicate handler1 was taken
	j end         	# Jump to exit

handler2:
	# This is where we land if we jump to handler2
	
	# fence 
	
	lw zero, (s0)	   # Load secret
	j end         	   # Jump to exit

end:
	# End program
	lui ra,0x10000
	li sp,4
	sb sp,0(ra)            
