# A program that increments a single-precision floating-point value
# (starting from 1.0) by adding 10 times the value 0.1.  Before each
# increment, the program prints on the console a message reporting the
# current value.  Then, the program exits.

.data        # The next items are stored in the Data memory segment
msg:         # Label for the mem addr of the first char of the string below
    .string "Your output is: "  # Allocate a string, in C-style: a
                                      # sequence of characters in adjacent
                                      # memory addresses, terminated with 0
not_positive_msg:         # Label for the mem addr of the first char of the string below
    .string "The number you have entered is not positive."  # Allocate a string, in C-style: a

.text        # The next items are stored in the Text memory segment

    li a7, 5  # ReadFloat 
    ecall     # Call ReadFloat
    blez a0, not_positive
    
    mv t0, a0  # Load value a0 into register t0 (number of increments)
    li t1, 1   # Load value 1 into register t1 (used as counter)
    li t2, 1   # Load value 1 into register t2 (used as counter increment)
    li t3, 0   # Load value 1 into register t2 (used as counter increment)
    fcvt.s.w ft3, t3, dyn

loop_begin:  # Label for memory location of the beginning of the loop

    li a7, 6  # ReadFloat
    ecall     # Call ReadFloat
    
    fadd.s f3, f3, fa0
    beq t0, t1, loop_end  # If t0 and t2 are equal, jump to loop_end

    add t1, t1, t2  # Increment loop couunter: add t0 and t1, result in t0

    j loop_begin  # Jump to the beginning of the loop

loop_end: # Label for memory location of the end of the loop
    la a0, msg  # Load address of label 'msg' into a0, for printing below
    li a7, 4    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    fmv.s fa0, ft3    # Load immediate value 4 into register a7
    li a7, 2        # Load value 2 into register a7
    ecall           # Syscall. In RARS, if a7=2, this means: "PrintFloat"

    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
    
not_positive:    
    la a0, not_positive_msg  # Load address of label 'msg' into a0, for printing below
    li a7, 4    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"