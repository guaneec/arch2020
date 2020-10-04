elem_suffix, elem_len = ('h', 2) # ('b', 1) | ('h', 2) | ('w', 4)
elem_log = len(bin(elem_len)) - 3
n = 10

src=f'''
# RISC-V

.text
main:
    li a0 {n + 1}
	# m = n * 10 / 3
    li a1 {(n + 1) * 10 // 3}

	# a = [2] * m
    li t0 2
    addi t1 a1 -1
	slli t1 t1 {elem_log}
L0:
	blt t1 zero L0E
	s{elem_suffix} t0 0x200(t1)
	addi t1 t1 -{elem_len}
	j L0
L0E:
	li t6 0
L1:
	ble a0 zero L1E

	addi t0 a1 -1
	li t1 10
	slli t0 t0 {elem_log}
L2:
	blt t0 zero L2E
	
	l{elem_suffix} t2 0x200(t0)
	mul t2 t2 t1
	s{elem_suffix} t2 0x200(t0)
	addi t0 t0 -{elem_len}
	
	j L2
L2E:
	addi t0 a1 -1
	slli t0 t0 {elem_log}
L3:
	ble t0 zero L3E

	l{elem_suffix} t1 0x200(t0)
    srai t2 t0 {elem_log}
	slli t2 t2 1
	addi t2 t2 1
	div t3 t1 t2
	rem t4 t1 t2
	s{elem_suffix} t4 0x200(t0)
	mul t3 t3 t0
	srai t3 t3 {elem_log}
	l{elem_suffix} t4 {hex(0x200-elem_len)}(t0)
	add t3 t3 t4
	s{elem_suffix} t3 {hex(0x200-elem_len)}(t0)
	addi t0 t0 -{elem_len}

	j L3
L3E:

	l{elem_suffix} t0 0x200(zero)
	li t1 10
	div t2 t0 t1
	rem t3 t0 t1
	s{elem_suffix} t3 0x200(zero)

	li t1 8
	
	bgt t2 t1 C0
	mv t0 a1
	add t1 a1 t6
L4:
	bge t0 t1 L4E
	slli t4 t0 {elem_log}
	l{elem_suffix} t3 0x200(t4)
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
	slli t0 a1 {elem_log}
	s{elem_suffix} t2 0x200(t0)
	j C0E
C0:
	li t0 9
	bne t2 t0 C1
	add t1 t6 a1
	slli t1 t1 {elem_log}
	s{elem_suffix} t0 0x200(t1)
	addi t6 t6 1
	j C1E
C1:
	mv t0 a1
	add t1 a1 t6
L5:
	bge t0 t1 L5E
	slli t4 t0 {elem_log}
	l{elem_suffix} t2 0x200(t4)
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
	slli t0 a1 {elem_log}
	s{elem_suffix} zero 0x200(t0)
C1E:
C0E:	
	addi a0 a0 -1
	j L1
L1E:
'''

print(src)