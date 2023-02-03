# A program that increments a single-precision floating-point value
# (starting from 1.0) by adding 10 times the value 0.1.  Before each
# increment, the program prints on the console a message reporting the
# current value.  Then, the program exits.

.data        # The next items are stored in the Data memory segment
msg:         # Label for the mem addr of the first char of the string below
    .string "Your output is: "  # Allocate a string, in C-style: a
                                      # sequence of characters in adjacent
                                      # memory addresses, terminated with 0
negative_msg:         # Label for the mem addr of the first char of the string below
    .string "The number you have entered is negative, no factorial exists."  # Allocate a string, in C-style: a
 
.text        # The next items are stored in the Text memory segment

    li a7, 5  # ReadInt 
    ecall     # Call ReadInt
    bltz a0, less_than_zero
    beqz a0, exact_zero

    mv t0, a0  # Load value 10 into register t0 (number of increments)
    li t1, 1   # Load value 0 into register t1 (used as counter)
    li t2, 1   # Load value 1 into register t2 (used as counter increment)
    li t3, 1   # Load value 1 into register t3 (used as output value)

loop_begin:  # Label for memory location of the beginning of the loop

    mul t3,t1,t3
    beq t0, t1, loop_end  # If t0 and t2 are equal, jump to loop_end

    add t1, t1, t2  # Increment loop couunter: add t0 and t1, result in t0

    j loop_begin  # Jump to the beginning of the loop

loop_end: # Label for memory location of the end of the loop
    la a0, msg  # Load address of label 'msg' into a0, for printing below
    li a7, 4    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    mv a0, t3    # Load immediate value 4 into register a7
    li a7, 1        # Load value 2 into register a7
    ecall           # Syscall. In RARS, if a7=2, this means: "PrintFloat"

    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
    
less_than_zero:    
    la a0, negative_msg  # Load address of label 'msg' into a0, for printing below
    li a7, 4    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"

exact_zero:     
    la a0, msg  # Load address of label 'msg' into a0, for printing below
    li a7, 4    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    li a0, 1    # Load address of label 'msg' into a0, for printing below
    li a7, 1    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"