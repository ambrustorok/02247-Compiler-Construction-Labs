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
    li a7, 5  # ReadInt 
    ecall     # Call ReadInt
    mv t0, a0 # Save value to t0
   
    li a7, 5  # ReadInt
    ecall     # Call ReadInt
    mv t1, a0 # Save value to t0
    
    beq t0, t1, ints_equal  # If t0 and t2 are equal, jump to loop_end
    blt t0, t1, second_greater     
    b first_greater

    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
        
ints_equal:
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
    