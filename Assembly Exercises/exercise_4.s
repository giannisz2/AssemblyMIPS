# CHECKS THE LARGEST BYTE VALUE, SMALLEST BYTE VALUE, SUM OF BYTES AND MEAN OF BYTES OF AN INPUT INTEGER

.text
    .globl main
main:
        li $s7, 4

    while:  la $a0, msg1
            li $v0, 4
            syscall

            li $v0, 5
            syscall
            move $t0, $v0

            move $a0, $v0
            li $v0, 1
            syscall

            jal print_endl

            beqz $t0, end_program
        
            # first byte
            sra $s0, $t0, 24

            # second byte    
            sll $s1, $t0, 8
            sra $s1, $s1, 24
            
            # third byte
            sll $s2, $t0, 16
            sra $s2, $s2, 24

            # fourth byte
            sll $s3, $t0, 24
            sra $s3, $s3, 24

            move $t7, $s0
            move $t6, $s0

            # max
            bgt $t7, $s1, max1
            move $t7, $s1
    max1:   bgt $t7, $s2, max2
            move $t7, $s2
    max2:   bgt $t7, $s3, endmax
            move $t7, $s3

    endmax: la $a0, msg2
            li $v0, 4
            syscall

            move $a0, $t7
            li $v0, 1
            syscall

            jal print_endl

            # min
            blt $t6, $s1, min1
            move $t6, $s1
    min1:   blt $t6, $s2, min2
            move $t6, $s2
    min2:   blt $t6, $s3, endmin
            move $t6, $s3

    endmin: la $a0, msg3
            li $v0, 4
            syscall

            move $a0, $t6
            li $v0, 1
            syscall

            jal print_endl

            add $t5, $s0, $s1
            add $t5, $t5, $s2
            add $t5, $t5, $s3

            la $a0, msg4
            li $v0, 4
            syscall

            move $a0, $t5
            li $v0, 1
            syscall

            jal print_endl

            div $t5, $s7
            mflo $t4

            la $a0, msg5
            li $v0, 4
            syscall

            move $a0, $t4
            li $v0, 1
            syscall

            jal print_endl
            jal print_endl

            j while

end_program:    jal print_endl

                la $a0, zero
                li $v0, 4
                syscall

                li $v0, 10
                syscall

print_endl: la $a0, endl
            li $v0, 4
            syscall
            jr $ra
.data
msg1: .asciiz "Give integer: "
msg2: .asciiz "Largest byte value is: "
msg3: .asciiz "Smallest byte value is: "
msg4: .asciiz "Sum of bytes is: "
msg5: .asciiz "Mean of bytes is: "
endl: .asciiz "\n"
zero: .asciiz "You typed 0, program ends."  
