.data
input:    .space 100000
fmt:      .asciz "%s"
yesmsg:   .asciz "Yes\n"
nomsg:    .asciz "No\n"

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)
    la a0, fmt
    la a1, input
    call scanf
    la t0, input
    mv t1, t0
    li t2, 0

len_loop:
    lb t3, 0(t1)
    beq t3, zero, len_done
    addi t2, t2, 1
    addi t1, t1, 1
    j len_loop

len_done:
    mv t1, t0
    add t4, t0, t2
    addi t4, t4, -1

pal_loop:
    bge t1, t4, ispal
    lb t5, 0(t1)
    lb t6, 0(t4)
    bne t5, t6, notpal
    addi t1, t1, 1
    addi t4, t4, -1
    j pal_loop

ispal:
    la a0, yesmsg
    call printf
    j exit

notpal:
    la a0, nomsg
    call printf

exit:
    ld ra, 8(sp)
    addi sp, sp, 16
    li a0, 0
    ret
