# GIVEN AN INTEGER NUMBER, PRINT THE NUMBER IN EXPONENTIAL FORM USING ONLY POWERS OF 10, EXAMPLE: 1267 = 1*10^3 + 2*10^2 + 6*10^1 + 7*10^0

.text
    .globl main
main:
            # read int
            li $v0, 5
            syscall
            move $t0, $v0

            li $t7, 10 # constant
            li $t5, 0 # digits

while:      beqz $t0, exit

            li $t6, 1 # counter of power to 10
            move $s0, $t0 # save $t0

while_n:    # count digits 
            div $t0, $t7
            mflo $t0 # quotient
            beqz $t0, end
            mul $t6, $t6, $t7
            addi $t5, 1 # digits + 1

            j while_n

end:        # retrieve $t0
            move $t0, $s0

while2:     beqz $t0, exit2 # if number is 0, exit

            div $t0, $t6 # div number and keep its remainder each time until it gets 0
            mflo $s1
            mfhi $t0

            div $t6, $t7 # div pow10 counter by 10 so we can get the next digits with the div in the next iteration
            mflo $t6

            move $a0, $s1 # print quotient 
            li $v0, 1
            syscall

            la $a0, symbol3 # print symbol
            li $v0, 4
            syscall

            move $a0, $t7 # print 10
            li $v0, 1
            syscall

            la $a0, symbol # print symbol
            li $v0, 4
            syscall

            move $a0, $t5 # print counter which has the role of the power to 10
            li $v0, 1
            syscall

            beqz $t0, exit2 # if number #t0 gets 0 then exit and don't print extra symbol
            la $a0, symbol2
            li $v0, 4
            syscall

            addi $t5, -1 # decrease counter by 1 which has the role of the power to 10

            j while2

exit2:      
        la $a0, endl
        li $v0, 4
        syscall

        # read int again before next iteration
        li $v0, 5
        syscall
        move $t0, $v0

        li $t5, 0 # initialize counter before next loop

        j while

exit:   la $a0, msg
        li $v0, 4
        syscall
        
        li $v0, 10
        syscall

.data

symbol: .asciiz "^"
symbol2: .asciiz " + "
symbol3: .asciiz "*"
msg: .asciiz "\nYou entered 0, the program ends. "
endl: .asciiz "\n"
