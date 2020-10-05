print4:
	addi sp sp -8
	sw s0 0(sp)
	sw s1 4(sp)
	li s1 10
	mv s0 a0
	li t0 1000
	div a0 s0 t0
	li a7 1
	ecall
	li t0 100
	div a0 s0 t0
	rem a0 a0 s1
	li a7 1
	ecall
	li t0 10
	div a0 s0 t0
	rem a0 a0 s1
	li a7 1
	ecall
	rem a0 s0 s1
	li a7 1
	ecall
	li a0 4
	lw s0 0(sp)
	lw s1 4(sp)
	addi sp sp 8
	ret
