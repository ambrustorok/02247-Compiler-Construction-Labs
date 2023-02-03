# A simple program that adds two integers (one stored in memory, the other
# immediate), stores the result in memory, and exits.

.data        # The next items are stored in the Data memory segment
value:       # Label for the memory address of the value below
    .word 3  # Allocate a word (size: 4 bytes) and initialise it to value 3
result:      # Label for the memory address of the value below
    .word 123  # Allocate a word (size: 4 bytes) and initialise it to value 0

.text         # The next items are stored in the Text memory segment
    li a7, 6  # ReadFloat 
    ecall     # Call ReadFloat
    fmv.s ft0, fa0 # Save value to ft0
    li a7, 6  # ReadFloat
    ecall     # Call ReadFloat
    fmv.s ft1, fa0 # Save value to ft1
    fadd.s fa0, ft0, ft1  # Add contents of t0 and t1, store result in t2
    	
    li a7, 2   # PrintInt 
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
    
    li a7, 10  # Load the immediate value 10 in register a7
    ecall      # Perform syscall. In RARS, if a7 is 10, this means: "Exit"
