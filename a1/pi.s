
# RISC-V

.data
arr: .half 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
pred: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
main:
	addi sp sp -32
	sw s0 0(sp)
	sw s1 4(sp)
	sw s2 8(sp)
	sw s4 16(sp)
	sw s5 20(sp)
	sw s7 28(sp)

	la s0 arr # arr.begin()
	la s1 pred # arr.end(), pred.begin()
	la s2 pred # pred.end()
	# s4: main loop counter
	# s5: digit output
	# s7: m

	li s4 100
	li s7 333
L1: # for _ in range(n)
	ble s4 zero L1E


	li t0 10
	mv t1 s0
L2: # [x * 10 for x in a]
	beq t1 s1 L2E
	lh t2 0(t1)
	mul t2 t2 t0
	sh t2 0(t1)
	addi t1 t1 2
	j L2
L2E:

	addi t0 s7 -1 # t0: i
	slli t1 t0 1
	add t1 s0 t1 # t1: a.begin() + i
L3: # for i in range(m - 1, 0, -1):
	ble t0 zero L3E
	lh t5 0(t1)
	slli t2 t0 1
	addi t2 t2 1
	divu t3 t5 t2
	remu t4 t5 t2
	sh t4 0(t1)
	mul t3 t3 t0
	lh t4 -2(t1)
	add t3 t3 t4
	sh t3 -2(t1)

	addi t0 t0 -1
	addi t1 t1 -2

	j L3
L3E:
	# d, a[0] = divmod(a[0], 10)
	lh t0 0(s0)
	li t1 10
	divu s5 t0 t1
	remu t3 t0 t1
	sh t3 0(s0)

	li t1 8
# C0: if d <= 8
	bgt s5 t1 C0
	mv t0 s1 # t0: pred.begin() + i
L4: # for p in pred:
	beq t0 s2 L4E
	lb t3 0(t0)

	# print
	mv a0 t3
	li a7 1
	ecall

	addi t0 t0 1
	j L4
L4E:
	addi s2 s1 1 # pred.end() = pred.begin() + 1
	sb s5 0(s1) # pred[0] = d
	j C0E
C0:
	li t0 9
	# if d == 9:
	bne s5 t0 C1
	sb s5 0(s2)
	addi s2 s2 1
	j C1E
C1:
	mv t0 s1 # t0: pred.begin() + i
L5: # for p in pred
	beq t0 s2 L5E
	lb t2 0(t0)
	addi t2 t2 1
	li t3 10
	remu a0 t2 t3
	li a7 1
	ecall
	addi t0 t0 1
	j L5
L5E:
	# pred = [0]
	sb zero 0(s1)
	addi s2 s1 1
C1E:
C0E:
	addi s4 s4 -1
	j L1
L1E:
	lw s0 0(sp)
	lw s1 4(sp)
	lw s2 8(sp)
	lw s4 16(sp)
	lw s5 20(sp)
	lw s7 28(sp)
	addi sp sp 32

