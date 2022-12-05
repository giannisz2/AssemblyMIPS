.text
    .globl main
main:
        li $s0, 22 # constant 31
        li $t1, 1 # constant 1
        li.s $f7, 0.0

while:  li $v0, 6
        syscall
        mov.s $f1, $f0
        c.eq.s $f1, $f7
        bc1t exit

        li $t7, 31 # counter of shifts
        li $t6, 0 # counter of 1's
        li $t5, 0 # counter of 0's

        mov.s $f12, $f1
        li $v0, 2
        syscall

    loop:       add $t4, $t5, $t6 # add both counters
                bgt $t4, $s0, end # if they are bigger than 23 stop, because fraction field is 23 bits
                mfc1 $t2, $f1   # convert float to integer to IEEE Std 754-1985
                
                sll $t2, $t2, $t7 # shift $t7 times bit to left 
                srl $t2, $t2, 31 # and keep the 31 - $t7 bit

                bne $t2, $t1, zero # if $t2 which the the bit you want is 1 increase $t6 counter or if its is 0 increase $t5 counter
                addi $t6, 1 # increase 1's counter
                addi $t7, -1 # decrease $t7 so you can get next bit next time you shift
                j loop

        zero:   addi $t5, 1 # increase 0's counter
                addi $t7, -1 # decrease $t7 so you can get next bit next time you shift
                j loop

    end:   # print msg 1
            la $a0, msg1
            li $v0, 4
            syscall

            # print 0's counter
            move $a0, $t5
            li $v0, 1
            syscall

            # print end line
            la $a0, endl
            li $v0, 4
            syscall

            # print msg2
            la $a0, msg2
            li $v0, 4
            syscall

            # print 1's counter
            move $a0, $t6
            li $v0, 1
            syscall

            la $a0, endl
            li $v0, 4
            syscall

            j while

exit:       la $a0, msg3
            li $v0, 4
            syscall

            li $v0, 10
            syscall

.data

endl: .asciiz "\n"
msg1: .asciiz "\nThe 0's are: "
msg2: .asciiz "The 1's are: "
msg3: .asciiz "\nYou gave number 0, the program ends."