# A simple program that adds two integers (one stored in memory, the other
# immediate), stores the result in memory, and exits.

.data        # The next items are stored in the Data memory segment
Equal:
    .string "Your two numbers are equal.\n"
    
FirstGreater:
    .string "Your first number is greater.\n"

SecondGreater:
    .string "Your second number is greater.\n"


.text         # The next items are stored in the Text memory segment
    li t4, 1 # for comparison
    
    li a7, 6  # ReadFloat
    ecall     # Call ReadFloat
    fmv.s ft0, fa0 # Save value to t0
   
    li a7, 6  # ReadFloat
    ecall     # Call ReadFloat
    fmv.s ft1, fa0 # Save value to t0
    
    feq.s t3, ft0, ft1
    beq t3,t4,floats_equal
    
    flt.s t3, ft0, ft1
    beq t3,t4,second_greater

    fgt.s t3, ft0, ft1
    beq t3,t4,first_greater
    
   
    b end     
floats_equal:
    la a0, Equal # Load the immediate value 10 in register a7
    li a7, 4  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
    b end
    
first_greater:
    la a0, FirstGreater # Load the immediate value 10 in register a7
    li a7, 4  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
    b end
    
second_greater:
    la a0, SecondGreater # Load the immediate value 10 in register a7
    li a7, 4  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
    b end
    
end:
    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
    