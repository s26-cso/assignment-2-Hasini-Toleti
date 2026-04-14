.data
input:    .space 100000     //buffer to store input string
fmt:      .asciz "%s"
yesmsg:   .asciz "Yes\n"
nomsg:    .asciz "No\n"

.text
.globl main

main:
    addi sp, sp, -16
    sd ra, 8(sp)   //return address
    la a0, fmt
    la a1, input
    call scanf
    la t0, input
    mv t1, t0     //t1=pointer for length calc
    li t2, 0    //t2=length counter

len_loop:
    lb t3, 0(t1)    //load byte
    beq t3, zero, len_done   //stop at \0
    addi t2, t2, 1   //increase length
    addi t1, t1, 1   //move forward
    j len_loop

len_done:
    mv t1, t0     //left=start of string
    add t4, t0, t2    //t4=end address
    addi t4, t4, -1    //to go to the last valid character

pal_loop:
    bge t1, t4, ispal     //if the pointers cross then palindrome
    lb t5, 0(t1)   //left char
    lb t6, 0(t4)     //right char 
    bne t5, t6, notpal   // if they do not match it is not a palindrome
    addi t1, t1, 1     //move left pointer forward
    addi t4, t4, -1    //move right pointer backward
    j pal_loop

ispal:
    la a0, yesmsg
    call printf
    j exit

notpal:
    la a0, nomsg
    call printf


exit:    //restore stack
    ld ra, 8(sp)
    addi sp, sp, 16
    li a0, 0
    ret


