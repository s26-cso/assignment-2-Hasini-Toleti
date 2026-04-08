.data
filename:.asciz "input.txt"
buffer: .byte 0
yesmsg:  .asciz "Yes\n"
nomsg:   .asciz "No\n"

.text
.global

main:
    li a7,56
    li a0,-100
    la a1,filename
    li a2,0
    li a3,0
    ecall
    mv s0,a0

    li a7,62
    mv a0,s0
    li a1,0
    li a2,2
    ecall
    mv s2,a0

    addi s2,s2,-1
    li s1,0

palloop:
    bge s1,s2,ispal
    li a7,62
    mv a0,s0
    mv a1,s1
    li a2,0
    ecall

    li a7,63
    mv a0,s0
    la a1,buffer
    li a2,1
    ecall
    lb t0,buffer

    li a7,62
    mv a0,s0
    mv a1,s2
    li a2,0
    ecall

    li a7,63
    mv a0,s0
    la a1,buffer
    li a2,1
    ecall
    lb t1,buffer

    bne t0,t1,notpal

    addi s1,s1,1
    addi s2,s2,-1
    j palloop

ispal:
    li a7,64
    li a0,1
    la a1,yesmsg
    li a2,4
    ecall
    j exit

notpal:
    li a7,64
    li a0,1
    la a1,nomsg
    li a2,3
    ecall

exit:
    li a7,93
    li a0,0
    ecall