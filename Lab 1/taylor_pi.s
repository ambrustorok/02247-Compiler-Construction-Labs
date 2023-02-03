# https://courses.compute.dtu.dk/02247/f23/risc-v.html#lab-exercises:~:text=on%20the%20console.-,Exercise%208,-(Approximation%20of%20Pi
# Calculates PI using the Taylor expansion.
# Reads an integer n from the console, and checks whether it is positive.
# If n is positive, the program computes and prints on the console the approximation of calculated using the Taylor expansion up to the n-th term.

.data        # The next items are stored in the Data memory segment
msg:         # Label for the mem addr of the first char of the string below
    .string "Your output is: "        # Allocate a string, in C-style: a
                                      # sequence of characters in adjacent
                                      # memory addresses, terminated with 0
not_positive_msg:         # Label for the mem addr of the first char of the string below
    .string "The number you have entered is not positive."  # Allocate a string, in C-style: a

.text        # The next items are stored in the Text memory segment

    li a7, 5  # Set ReadInt
    ecall     # Call ReadInt
    blez a0, not_positive
    
    mv t0, a0  # Load value a0 into register t0 (number of increments)
    li t1, 0   # Load value 1 into register t1 (used as counter)
    li t2, 1   # Load value 1 into register t2 (used as counter increment)
    li t3, 1   # For onversion, our sum starts at 0
    fcvt.s.w ft3, t3, dyn # 
    
    li t6, 2 # For checking if even or odd

loop_begin:  # while

    beq t0, t1, loop_end  # If t0 and t2 are equal, jump to loop_end
    add t1, t1, t2  # Increment loop couunter: add t0 and t1, result in t0

    rem a0,t1,t6 # The counter (t1) divided by 2 (t6) gives us a hint if we are in a public or an even loop, also known as we need to add or subtract.
    beqz a0, even
    j odd
    
even: # we add
    
    fcvt.s.w ft1, t1, dyn # copy n to float
    fadd.s ft1, ft1, ft1 # 2n 
    
    fcvt.s.w ft2, t2, dyn # copy 1 to float
    fadd.s ft1, ft1, ft2 # +1  
    
    fdiv.s ft1, ft2, ft1, dyn # 1/
    
    # Add float to current sum 
    fadd.s f3, f3, ft1
    j loop_begin  # Jump to the beginning of the loop

odd: # we subtract
    fcvt.s.w ft1, t1, dyn # copy n to float
    fadd.s ft1, ft1, ft1 # 2n 
    
    fcvt.s.w ft2, t2, dyn # copy 1 to float
    fadd.s ft1, ft1, ft2 # +1  
    
    fdiv.s ft1, ft2, ft1, dyn # 1/
    
    # Add float to current sum 
    fsub.s f3, f3, ft1
    j loop_begin  # Jump to the beginning of the loop

loop_end: # Label for memory location of the end of the loop
    la a0, msg  # Load address of label 'msg' into a0, for printing below
    li a7, 4    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    # Multiplication with 4 at the end
    li t4, 4   # Load value 1 into register t2 (used as counter increment)
    fcvt.s.w ft4, t4, dyn
    fmul.s ft3, ft3, ft4

    # Print results 
    fmv.s fa0, ft3    # Load immediate value 4 into register a7
    li a7, 2        # Load value 2 into register a7
    ecall           # Syscall. In RARS, if a7=2, this means: "PrintFloat"
    
    # Return 0, end of execution
    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"

not_positive:    
    la a0, not_positive_msg  # Load address of label 'msg' into a0, for printing below
    li a7, 4    # Load immediate value 4 into register a7
    ecall       # Syscall. In RARS, if a7=4, this means: "PrintString"

    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
