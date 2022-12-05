.text
    .globl main
main:

    lwc1 $f7, zero
    li $t7, 0
    li $s0, 1
    li $s1, 9
    li $t6, 31

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

        la $a0, msg3
        li $v0, 4
        syscall

        move $a0, $s7
        li $v0, 1
        syscall

        jal print_spc
        jal print_spc

        addi $t7, 1

        la $a0, msg4
        li $v0, 4
        syscall

        while2: beq $t7, $s1, exit # if counter = 9 then we go to next loop for fraction

                sll $s7, $t0, $t7
                srl $s7, $s7, $t6

                addi $t7, 1

                move $a0, $s7
                li $v0, 1
                syscall
                
                j while2

        exit:   jal print_spc
                jal print_spc
                la $a0, msg5
                li $v0, 4
                syscall

        while3: beq $t7, $t6, end_loop # if counter = 31 we are done

                sll $s7, $t0, $t7
                srl $s7, $s7, $t6

                addi $t7, 1

                move $a0, $s7
                li $v0, 1
                syscall

                j while3
        
end_loop:   li $t7, 0 # initialize counter for next number given
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
msg2: .asciiz " You typed 0, the program ends."
msg3: .asciiz "SIGN = "
msg4: .asciiz "EXPONENT = "
msg5: .asciiz "FRACTION = "
endl: .asciiz "\n"
spc: .asciiz " "
zero: .float 0.0