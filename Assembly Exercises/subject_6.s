# GIVEN A STRING, PRINT THE SUMMARY OF DIFFERENT CHARACTERS THAT ARE NEXT TO EACH OTHER

.text
    .globl main
main:
    li $t6, 10
    li $t7, 1

    la $a0, msg1
    li $v0, 4
    syscall

    la $a0, string
    li $v0, 8
    syscall

    li $v0, 4
    syscall

    jal print_endl

    la $s0, string

while:  lbu $t0, 0($s0)
        move $s1, $s0 # move the pointer of string to $s1 and add 1 to get to next char for loop
        addi $s1, 1

        beqz $t0, end_program
        while2: lbu $t1, 0($s1)
                bne $t0, $t1, next
                beqz $t0, next

                addi $t7, 1
                addi $s1, 1

                j while2

        next:   beq $t0, $t6, end_program # if char = enter then exit program

                move $a0, $t7
                li $v0, 1
                syscall

                add $s0, $s0, $t7 # add $t7 into the pointer so we can get to next char which isn't the same 
                
                jal print_spc

                li $t7, 1

                j while




end_program:    li $v0, 10
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

string: .space 90
msg1: .asciiz "You give the string: "
endl: .asciiz "\n"
spc: .asciiz " "
