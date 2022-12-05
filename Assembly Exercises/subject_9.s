.text
    .globl main
main:

    lwc1 $f7, zero
    li $t7, 0
    li $s1, 9 # start of fraction
    li $s2, 258 # bias
    li $s3, 13
    li $t6, 31 # constant

while1: la $a0, msg1
        li $v0, 4
        syscall

        li $v0, 6
        syscall 
        mov.s $f1, $f0

        mov.s $f12, $f0
        li $v0, 2
        syscall

        jal print_endl

        c.eq.s $f1, $f7
        bc1t end_program

        # convert number to IEEE 754
        mfc1 $t0, $f1

        # first shift for sign
        srl $s7, $t0, $t6

        la $a0, msg6
        li $v0, 4
        syscall

        beqz $s7, case_0 # if first sign is negative then print "-"
        la $a0, msg3
        li $v0, 4
        syscall

case_0: move $a0, $s7
        li $v0, 1
        syscall

        addi $t7, 9

        # exponent bit 1-8
        sll $s7, $t0, 1
        srl $s7, $s7, 23
        sub $s7, $s7, $s2
        move $s6, $s7

        la $a0, msg4
        li $v0, 4
        syscall

        # loop for fraction
        while2: beq $t7, $s3, end_loop # if counter = 31 we are done

                sll $s7, $t0, $t7
                srl $s7, $s7, $t6

                addi $t7, 1

                move $a0, $s7
                li $v0, 1
                syscall

                j while2
        
end_loop:   li $t7, 0 # initialize counter

            la $a0, msg5
            li $v0, 4
            syscall

            move $a0, $s6
            li $v0, 1
            syscall

            jal print_endl
            jal print_endl

            j while1


end_program:    jal print_endl

                la $a0, msg2
                li $v0, 4
                syscall

                li $v0, 10
                syscall
                

print_endl: la $a0, endl
            li $v0, 4
            syscall
            jr $ra

print_spc:  la $a0, spc
            li $v0, 4
            syscall
            jr $ra
.data
msg1: .asciiz "Give a float: "
msg2: .asciiz "You typed 0, the program ends."
msg3: .asciiz "-"
msg4: .asciiz "."
msg5: .asciiz " x 2^"
msg6: .asciiz "The number in scientific notation is: "
endl: .asciiz "\n"
spc: .asciiz " "
zero: .float 0.0