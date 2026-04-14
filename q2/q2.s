.data
space:.asciz " "
newline:.asciz "\n"
ftint:.asciz "%d"
.text
.globl main

main:
    addi sp,sp,-72
    sd ra,56(sp)
    sd s0,48(sp)
    sd s1,40(sp)
    sd s2,32(sp)
    sd s3,24(sp)
    sd s4,16(sp)
    sd s5,8(sp)        
    mv s5,a1       

    addi s0,a0,-1
    blez s0,exit
    mv a0,s0
    slli a0,a0,2
    call malloc
    mv s1,a0
    mv a0,s0
    slli a0,a0,2
    call malloc
    mv s2,a0
    mv a0,s0
    slli a0,a0,2
    call malloc
    mv s3,a0
    li s4,-1
    li t0,1

ploop:
    bgt t0,s0,pdone
    slli t1,t0,3
    add t1,s5,t1
    ld a0,0(t1)
    call atoi
    addi t2,t0,-1
    slli t2,t2,2
    add t3,s1,t2
    sw a0,0(t3)
    addi t0,t0,1
    j ploop
pdone:
    li t0,0

initloop:
    bge t0,s0,idone
    slli t1,t0,2
    add t2,s2,t1
    li t3,-1
    sw t3,0(t2)
    addi t0,t0,1
    j initloop
idone:
    addi t0,s0,-1

mainloop:
    blt t0,zero,print

whileloop:
    blt s4,zero,whiledone
    slli t1,s4,2
    add t2,s3,t1
    lw t3,0(t2)
    slli t4,t3,2
    add t5,s1,t4
    lw t6,0(t5)
    slli t1,t0,2
    add t2,s1,t1
    lw t3,0(t2)
    bgt t6,t3,whiledone
    addi s4,s4,-1
    j whileloop
whiledone:
    blt s4,zero,skip
    slli t1,s4,2
    add t2,s3,t1
    lw t3,0(t2)
    slli t4,t0,2
    add t5,s2,t4
    sw t3,0(t5)
skip:
    addi s4,s4,1
    slli t1,s4,2
    add t2,s3,t1
    sw t0,0(t2)
    addi t0,t0,-1
    j mainloop

print:
    li t0,0
printloop:
    bge t0,s0,done
    slli t1,t0,2
    add t2,s2,t1
    lw a0,0(t2)
    call printint
    la a0,space
    call printf
    addi t0,t0,1
    j printloop

done:
    la a0,newline
    call printf

exit:
    ld ra,56(sp)
    ld s0,48(sp)
    ld s1,40(sp)
    ld s2,32(sp)
    ld s3,24(sp)
    ld s4,16(sp)
    ld s5,8(sp)
    addi sp,sp,72
    li a0,0
    ret

printint:
    addi sp,sp,-16
    sd ra,8(sp)
    mv a1,a0
    la a0,ftint
    call printf
    ld ra,8(sp)
    addi sp,sp,16
    ret
