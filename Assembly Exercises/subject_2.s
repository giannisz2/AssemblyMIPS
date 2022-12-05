.text
    .globl __start
__start:

# Ο ΚΩΔΙΚΑΣ ΔΟΥΛΕΥΕΙ ΣΕ ΠΕΡΙΠΤΩΣΗ ΠΟΥ ΔΕΝ ΥΠΑΡΧΕΙ Ο ΑΡΙΘΜΟΣ 0 ΜΕΣΑ ΣΤΟ STRING
# Ο ΚΩΔΙΚΑΣ ΕΙΝΑΙ ΟΥΣΙΑΣΤΙΚΑ Η ΚΛΑΣΣΙΚΗ ΜΕΤΑΤΡΟΠΗ ΔΕΚΑΔΙΚΟΥ ΣΕ ΔΥΑΔΙΚΟ ΟΠΩΣ ΚΑΝΑΜΕ ΣΤΝΝ ΛΟΓΙΚΗ ΣΧΕΔΙΑΣΗ

            li $t0, 0 # counter of string array
            li $s0, 128 # 2^7
            li $s1, 2 # constant 

            la $a0, str
            li $v0, 4
            syscall

            la $a0, symbol1
            li $v0, 4
            syscall

while:          lbu $t1, str($t0) # load first byte
                beqz $t1, exit # .if $t1 end of string then exit
            
    while2:         beqz $s0, end2 # .if $s0 which is divisor by 2 of byte equals zero, then we are done, get next char
                    div $t1, $s0   # byte / 2
                    mflo $t3    
            
                    beqz $t3, case_0    # if $s0 (current power of 2) is bigger then the current bit is 0 or else it's 1
                    sub $t1, $t1, $s0   # if it is 1, subtract the number $s0 from $t1 
                    div $s0, $s1        # get the previous power of 2 
                    mflo $s0

                    la $a0, msg1
                    li $v0, 4
                    syscall

                    j end

    case_0:         div $s0, $s1    # if number $t3 is smaller then just divide $s0 by 2 and continue
                    mflo $s0

                    la $a0, msg2
                    li $v0, 4
                    syscall

    end:            j while2    # loop

end2:       addi $t0, 1 # counter of array +1
            la $a0, symbol2 
            li $v0, 4
            syscall

            li $s0, 128 # initialize $s0 for the next byte 

            j while # loop

exit:   li $v0, 10
        syscall

.data
    str: .asciiz "Hello world"
    symbol1: .asciiz " = "
    symbol2: .asciiz " "
    msg1: .asciiz "1"
    msg2: .asciiz "0" 