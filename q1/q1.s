.text
.global make_node
.global insert
.global get
.global getAtMost

make_node:
    addi sp,sp,-16
    sd ra,8(sp)
    mv t0,a0
    li a0,24
    call malloc
    mv t1,a0
    sw t0,0(t1)
    sd zero,8(t1)
    sd zero,16(t1)
    mv a0,t1
    ld ra,8(sp)
    addi sp,sp,16
    ret

insert:
    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)
    mv s0,a0
    mv s1,a1
    bne s0,zero,insertnotzero
    mv a0,s1
    call make_node
    j done

insertnotzero:
    lw t0,0(s0)
    beq s1,t0,insertroot
    blt s1,t0,insertleft
    ld a0,16(s0)
    mv a1,s1
    call insert
    sd a0,16(s0)
    j insertroot

insertleft:
    ld a0,8(s0)
    mv a1,s1
    call insert
    sd a0,8(s0)

insertroot:
    mv a0,s0

done:
    ld ra,24(sp)
    ld s0,16(sp)
    ld s1,8(sp)
    addi sp,sp,32
    ret

get:
    beq a0,zero,getnull
    lw t0,0(a0)
    beq t0,a1,found
    blt a1,t0,goleft
    ld a0,16(a0)
    j get

goleft:
    ld a0,8(a0)
    j get
found:
    ret
getnull:
    li a0,0
    ret

getAtMost:
    li t1,-1
loop:
    beq a1,zero,atmostdone
    lw t0,0(a1)
    bgt t0,a0,getmostgoleft
    mv t1,t0
    ld a1,16(a1)
    j loop

getmostgoleft:
    ld a1,8(a1)
    j loop
atmostdone:
    mv a0,t1
    ret

    