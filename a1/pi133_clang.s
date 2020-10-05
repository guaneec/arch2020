main:                                   # @main
        addi    sp, sp, -48
        sw      ra, 44(sp)
        sw      s0, 40(sp)
        sw      s1, 36(sp)
        sw      s2, 32(sp)
        sw      s3, 28(sp)
        sw      s4, 24(sp)
        sw      s5, 20(sp)
        sw      s6, 16(sp)
        sw      s7, 12(sp)
        sw      s8, 8(sp)
        sw      s9, 4(sp)
        sw      s10, 0(sp)
        lui     s3, %hi(c)
        lw      a0, %lo(c)(s3)
        addi    a3, a0, -14
        sw      a3, %lo(c)(s3)
        lui     s9, %hi(b)
        sw      a3, %lo(b)(s9)
        beqz    a3, .LBB0_9
        lui     s2, %hi(f)
        lui     s10, %hi(d)
        lui     s4, %hi(e)
        lui     s5, %hi(g)
        lui     s6, %hi(h)
        lui     a0, 419430
        addi    s7, a0, 1639
        lui     a0, %hi(a)
        addi    s8, a0, %lo(a)
        j       .LBB0_4
.LBB0_2:                                #   in Loop: Header=BB0_4 Depth=1
        sw      a1, %lo(d)(s10)
        sw      zero, %lo(g)(s5)
        sw      zero, %lo(b)(s9)
.LBB0_3:                                #   in Loop: Header=BB0_4 Depth=1
        div     a0, a1, a7
        add     a0, a0, a6
        call    print4
        lw      a1, %lo(c)(s3)
        sw      a0, %lo(h)(s6)
        addi    a3, a1, -14
        sw      a3, %lo(c)(s3)
        sw      a3, %lo(b)(s9)
        beqz    a3, .LBB0_9
.LBB0_4:                                # =>This Loop Header: Depth=1
        lw      a7, %lo(f)(s2)
        lw      a1, %lo(d)(s10)
        rem     a6, a1, a7
        sw      a6, %lo(d)(s10)
        sw      a6, %lo(e)(s4)
        addi    a2, a3, -1
        sw      a2, %lo(b)(s9)
        slli    a1, a2, 1
        sw      a1, %lo(g)(s5)
        add     a1, zero, a6
        beqz    a2, .LBB0_3
        lw      a1, %lo(h)(s6)
        seqz    a4, a1
        mulh    a1, a7, s7
        srli    a5, a1, 31
        srai    a1, a1, 1
        add     s1, a1, a5
        slli    a1, a3, 1
        addi    s0, a1, -3
        slli    a1, a3, 2
        add     a1, a1, s8
        addi    a3, a1, -4
        add     a1, zero, a6
        j       .LBB0_7
.LBB0_6:                                #   in Loop: Header=BB0_7 Depth=2
        mul     a1, a1, a2
        mul     a5, a5, a7
        add     a5, a5, a1
        div     a1, a5, s0
        mul     a0, a1, s0
        sub     a0, a5, a0
        sw      a0, 0(a3)
        addi    a2, a2, -1
        addi    s0, s0, -2
        addi    a3, a3, -4
        beqz    a2, .LBB0_2
.LBB0_7:                                #   Parent Loop BB0_4 Depth=1
        add     a5, zero, s1
        bnez    a4, .LBB0_6
        lw      a5, 0(a3)
        j       .LBB0_6
.LBB0_9:
        mv      a0, zero
        lw      s10, 0(sp)
        lw      s9, 4(sp)
        lw      s8, 8(sp)
        lw      s7, 12(sp)
        lw      s6, 16(sp)
        lw      s5, 20(sp)
        lw      s4, 24(sp)
        lw      s3, 28(sp)
        lw      s2, 32(sp)
        lw      s1, 36(sp)
        lw      s0, 40(sp)
        lw      ra, 44(sp)
        addi    sp, sp, 48
        ret
c:
        .word   364                             # 0x16c

f:
        .word   10000                           # 0x2710

b:
        .word   0                               # 0x0

d:
        .word   0                               # 0x0

e:
        .word   0                               # 0x0

g:
        .word   0                               # 0x0

h:
        .word   0                               # 0x0

a:
        .zero   1456