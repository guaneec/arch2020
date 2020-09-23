# RISC-V

.data
argument: .word 100 # number of digits to calculate

.text
main:
	lw  a0, argument   # Load argument from static data
    addi a0 a0 1
	# m = n * 10 / 3
	li t0 10
	mul a1 a0 t0
	li t0 3
	div a1 a1 t0

	# a = [2] * m
    li t0 2
    addi t1 a1 -1
	slli t1 t1 2
L0:
	blt t1 zero L0E
	sw t0 0x200(t1)
	addi t1 t1 -4
	j L0
L0E:
	li t6 0
L1:
	ble a0 zero L1E

	addi t0 a1 -1
	li t1 10
	slli t0 t0 2
L2:
	blt t0 zero L2E
	
	lw t2 0x200(t0)
	mul t2 t2 t1
	sw t2 0x200(t0)
	addi t0 t0 -4
	
	j L2
L2E:
	addi t0 a1 -1
	slli t0 t0 2
L3:
	ble t0 zero L3E

	lw t1 0x200(t0)
	srai t2 t0 1
	addi t2 t2 1
	div t3 t1 t2
	rem t4 t1 t2
	sw t4 0x200(t0)
	mul t3 t3 t0
	srai t3 t3 2
	lw t4 0x1fc(t0)
	add t3 t3 t4
	sw t3 0x1fc(t0)
	addi t0 t0 -4

	j L3
L3E:

	lw t0 0x200(zero)
	li t1 10
	div t2 t0 t1
	rem t3 t0 t1
	sw t3 0x200(zero)

	li t1 8
	
	bgt t2 t1 C0
	mv t0 a1
	add t1 a1 t6
L4:
	bge t0 t1 L4E
	slli t4 t0 2
	lw t3 0x200(t4)
	# FIXME: print t3
	mv t5 a0
	mv a0 t3
	li a7 1
	ecall
	mv a0 t5	
	# END print t3
	addi t0 t0 1	
	j L4
L4E:
	li t6 1
	slli t0 a1 2
	sw t2 0x200(t0)
	j C0E
C0:
	li t0 9
	bne t2 t0 C1
	add t1 t6 a1
	slli t1 t1 2
	sw t0 0x200(t1)
	addi t6 t6 1
	j C1E
C1:
	mv t0 a1
	add t1 a1 t6
L5:
	bge t0 t1 L5E
	slli t4 t0 2
	lw t2 0x200(t4)
	addi t2 t2 1
	li t3 10
	rem t2 t2 t3
	# FIXME: print(t2)
	mv t5 a0
	mv a0 t2
	li a7 1
	ecall
	mv a0 t5
	# end print t2
	addi t0 t0 1
	j L5
L5E:
	li t6 1
	slli t0 a1 2
	sw zero 0x200(t0)
C1E:
C0E:	
	addi a0 a0 -1
	j L1
L1E: