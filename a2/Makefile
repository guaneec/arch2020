CC = riscv-none-embed-gcc
CFLAGS = -march=rv32i -mabi=ilp32 -O2 -nostdlib

%.s: %.c
	$(CC)  $^ -S -fverbose-asm $(CFLAGS)