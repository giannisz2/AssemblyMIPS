.text
    .globl __start
__start:
            # read and move number
            li $v0, 6
            syscall
            mov.s $f1, $f0
            mov.s $f2, $f0
            l.s $f3, float # constant 0

while:      c.eq.s $f0, $f3 # if number is 0, end program
            bc1t exit

            # convert back and forth to see if number is integer
            cvt.w.s $f2, $f2
            mtc1 $t2, $t2

            mfc1 $t2, $f2
            cvt.s.w $f2, $f2

            # .if number is same as before then it is integer else it's not
            c.eq.s $f1, $f2
            bc1f Label1

            la $a0, number
            li $v0, 4
            syscall
            
            mov.s $f12, $f0
            li $v0, 2
            syscall

            la $a0, integer
            li $v0, 4
            syscall

            j end
            
Label1:     la $a0, number
            li $v0, 4
            syscall
            
            mov.s $f12, $f0
            li $v0, 2
            syscall

            la $a0, not_integer
            li $v0, 4
            syscall

end:        # read number and move again before next loop
            li $v0, 6
            syscall
            mov.s $f1, $f0
            mov.s $f2, $f0

            j while 

exit:       la $a0, msg
            li $v0, 4
            syscall

            li $v0, 10
            syscall

.data
number: .asciiz "The number: "
integer: .asciiz " is an integer\n"
not_integer: .asciiz " is not an integer\n"
float: .float 0.0
msg: .asciiz "\nYou entered 0, program ends."