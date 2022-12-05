.text
    .globl main
main:

    li $s4, 1 # counter of 1st string for pos
    li $s5, 0 # flag for msg4
    li $t6, 10 # constant 10 for "enter"
    li $t7, 1 # counter of 2nd string for pos

    la $a0, msg1
    li $v0, 4
    syscall

    la $a0, string1
    li $v0, 8
    syscall

    li $v0, 4
    syscall

    la $a0, msg2
    li $v0, 4
    syscall

    la $a0, string2
    li $v0, 8
    syscall

    li $v0, 4
    syscall

    jal print_endl

    la $s0, string1 # load addresses
    la $s1, string2

    la $a0, msg3
    li $v0, 4
    syscall

    jal print_endl

while:  lbu $t0, 0($s0)
        beqz $t0, end_program

        move $a0, $t1 # print char
        li $v0, 11
        syscall

        beq $t0, $t6, end_program
        move $a0, $s4 # print pos of 1st string
        li $v0, 1
        syscall

        jal print_spc
        jal print_endl

        while2: lbu $t1, 0($s1)

                beqz $t1, exit_loop2
                bne $t0, $t1, next_c

                move $a0, $t1
                li $v0, 11
                syscall

                beq $t0, $t6, exit_loop2 # if char = "linefeed" then don't print counter $t7
                addi $s5, 1

                jal print_spc

                move $a0, $t7 # print position
                li $v0, 1
                syscall

                jal print_spc
                jal print_endl



            next_c: addi $s1, 1
                    addi $t7, 1
                    j while2
        
        
exit_loop2: la $s1, string2 # re-initialize pointer to second string
            addi $s4, 1 # add the counter o the first string for it's position
            addi $s0, 1 # add the pointer of the first string so we can get to next character
            li $t7, 1
            jal print_endl
            j while
            
end_program:    bnez $s5, end_program2
                la $a0, msg4
                li $v0, 4
                syscall


end_program2:   li $v0, 10
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
string1: .space 90
string2: .space 90
msg1: .asciiz "The strings you give are:  "
msg2: .asciiz "and  "
msg3: .asciiz "The same characters of the first in the second string are in positions: "
msg4: .asciiz "There are no same characters in those strings."
endl: .asciiz "\n"
spc: .asciiz " "