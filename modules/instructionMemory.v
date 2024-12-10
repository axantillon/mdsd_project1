module instructionMemory (
    input wire [7:0] address,
    input wire [7:0] programSelect,
    output wire [15:0] instruction
);
    //Program 1: Sum integers from 1 to N  
    reg [15:0] sumIntegersProgram [0:127];
    initial begin
        // Load N from input
        // Opcode: 0001 (Load from External Input)
        sumIntegersProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT (N)
        
        // Initialize sum register
        // Opcode: 0000 (Set to Constant)
        sumIntegersProgram[1] = 16'b0000_0010_0000_0000;  // R2 = 0 (sum)
        
        // Initialize loop counter
        // Opcode: 0000 (Set to Constant)
        sumIntegersProgram[2] = 16'b0000_0011_0000_0001;  // R3 = 1 (loop counter)
        
        // Loop start
        // Compare loop counter with N
        // Opcode: 1011 (Compare Greater Than)
        sumIntegersProgram[3] = 16'b1011_0100_0001_0011;  // R4 = (N >= loop counter)
        
        // Debug: Copy loop counter to R15
        sumIntegersProgram[4] = 16'b0010_1111_0011_0000;  // R15 = R3 (loop counter)
        
        // Conditionally jump to end of loop if loop counter > N
        // Opcode: 1111 (Conditional Halt)
        sumIntegersProgram[5] = 16'b1111_0000_0000_0100;  // Halt if R4 == 0
        
        // Add loop counter to sum
        // Opcode: 0100 (ADD)
        sumIntegersProgram[6] = 16'b0100_0010_0010_0011;  // R2 = R2 + R3
        
        // Debug: Copy sum to R15 after addition
        sumIntegersProgram[7] = 16'b0010_1111_0010_0000;  // R15 = R2 (sum)
        
        // Increment loop counter
        // Opcode: 0000 (Set to Constant)
        sumIntegersProgram[8] = 16'b0000_0011_0000_0001;  // R3 = R3 + 1
        
        // Jump back to loop start
        // Opcode: 1101 (Jump)
        sumIntegersProgram[9] = 16'b1101_0000_0000_0011;  // Jump to instruction 3 if R4 != 0
        
        // Copy final sum to output register
        // Opcode: 0010 (Copy)
        sumIntegersProgram[10] = 16'b0010_1111_0010_0000;  // R15 = R2
        
        // Halt
        // Opcode: 1110 (Halt)
        sumIntegersProgram[11] = 16'b1110_0000_0000_0000;  // HALT
    end

    //Testing Instructions for Program 1
    /*To test this program:
    1. Set switches to input N (a number between 1 and 15)
    2. Reset the system
    3. The display should show the sum of numbers from 1 to N, or 255 if the sum exceeds 255
     Example results:
        For N=4: Sum should be 10 (1+2+3+4)
        For N=5: Sum should be 15 (1+2+3+4+5)
        For N=15: Sum should be 120 (1+2+...+15) */


   // Program 2: Compute square of N
    reg [15:0] squareOfNProgram [0:127];
    // Program 2: Compute square of N   
    initial begin
        // Load N from input
        // Opcode: 0001 (Load from External Input)
        squareOfNProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT (N)
        
        // Initialize result register
        // Opcode: 0000 (Set to Constant)
        squareOfNProgram[1] = 16'b0000_0010_0000_0000;  // R2 = 0 (result)
        
        // Initialize loop counter
        // Opcode: 0000 (Set to Constant)
        squareOfNProgram[2] = 16'b0000_0011_0000_0001;  // R3 = 1 (loop counter)
        
        // Loop start
        // Compare loop counter with N
        // Opcode: 1011 (Compare Greater Than)
        squareOfNProgram[3] = 16'b1011_0100_0001_0011;  // R4 = (N >= loop counter)
        
        // Debug: Copy loop counter to R15
        squareOfNProgram[4] = 16'b0010_1111_0011_0000;  // R15 = R3 (loop counter)
        
        // Conditionally jump to end of loop if loop counter > N
        // Opcode: 1111 (Conditional Halt)
        squareOfNProgram[5] = 16'b1111_0000_0000_0100;  // Halt if R4 == 0
        
        // Add N to result
        // Opcode: 0100 (ADD)
        squareOfNProgram[6] = 16'b0100_0010_0010_0001;  // R2 = R2 + R1
        
        // Debug: Copy result to R15 after addition
        squareOfNProgram[7] = 16'b0010_1111_0010_0000;  // R15 = R2 (result)
        
        // Increment loop counter
        // Opcode: 0000 (Set to Constant)
        squareOfNProgram[8] = 16'b0000_0011_0000_0001;  // R3 = R3 + 1
        
        // Jump back to loop start
        // Opcode: 1101 (Jump)
        squareOfNProgram[9] = 16'b1101_0000_0000_0011;  // Jump to instruction 3 if R4 != 0
        
        // Copy final result to output register
        // Opcode: 0010 (Copy)
        squareOfNProgram[10] = 16'b0010_1111_0010_0000;  // R15 = R2
        
        // Halt
        // Opcode: 1110 (Halt)
        squareOfNProgram[11] = 16'b1110_0000_0000_0000;  // HALT
    end



    // Program 3: Load 4 into R1; Load 5 into R2; Add R1 and R2, store in R15
    reg [15:0] thirdProgram [0:127];
    initial begin
        // Load immediate value 2 into R1
        // Opcode: 0000 (Set to Constant), Reg: 0001 (R1), Value: 00000010 (2)
        thirdProgram[0] = 16'b0000_0001_0000_0010;

        // Copy R1 to R15
        // Opcode: 0010 (Copy), Dest: 1111 (R15), Src: 0001 (R1)
        thirdProgram[1] = 16'b0010_1111_0001_0000;

        // Load immediate value 3 into R2
        // Opcode: 0000 (Set to Constant), Reg: 0010 (R2), Value: 00000011 (3)
        thirdProgram[2] = 16'b0000_0010_0000_0011;

        // Copy R2 to R15
        // Opcode: 0010 (Copy), Dest: 1111 (R15), Src: 0010 (R2)
        thirdProgram[3] = 16'b0010_1111_0010_0000;

        // Add R1 and R2, store result in R15
        // Opcode: 0100 (ADD), Dest: 1111 (R15), Src1: 0010 (R2), Src2: 0001 (R1)
        thirdProgram[4] = 16'b0100_1111_0010_0001;

        thirdProgram[5] = 16'b0001_0100_0000_0000; // R8 = input

        thirdProgram[6] = 16'b0100_1111_1111_0100; // R15 = R15 + R8

        // Halt execution
        // Opcode: 1110 (HALT)
        thirdProgram[7] = 16'b1110_0000_0000_0000;
    end

    // Program 4: Calculate Fibonacci sequence
    reg [15:0] fibonacciProgram [0:127];
    initial begin
        // Load N from input
        // Opcode: 0001 (Load from External Input)
        fibonacciProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT (N)
        
        // Initialize first two numbers
        // Opcode: 0000 (Set to Constant)
        fibonacciProgram[1] = 16'b0000_0010_0000_0000;  // R2 = 0 (F0)
        // Opcode: 0000 (Set to Constant)
        fibonacciProgram[2] = 16'b0000_0011_0000_0001;  // R3 = 1 (F1)
        
        // Initialize loop counter
        // Opcode: 0000 (Set to Constant)
        fibonacciProgram[3] = 16'b0000_0100_0000_0010;  // R4 = 2 (loop counter)
        
        // Loop start
        // Compare loop counter with N
        // Opcode: 1011 (Compare Greater Than)
        fibonacciProgram[4] = 16'b1011_0101_0001_0100;  // R5 = (N >= loop counter)
        
        // Debug: Copy loop counter to R15
        fibonacciProgram[5] = 16'b0010_1111_0011_0000;  // R15 = R4 (loop counter)
        
        // Conditionally jump to end of loop if loop counter > N
        // Opcode: 1111 (Conditional Halt)
        fibonacciProgram[6] = 16'b1111_0000_0000_0101;  // Halt if R5 == 0
        
        // Calculate next Fibonacci number
        // Opcode: 0100 (ADD)
        fibonacciProgram[7] = 16'b0100_0110_0010_0011;  // R6 = R2 + R3
        
        // Debug: Copy Fibonacci number to R15
        fibonacciProgram[8] = 16'b0010_1111_0110_0000;  // R15 = R6 (Fibonacci number)
        
        // Update previous numbers
        // Opcode: 0010 (Copy)
        fibonacciProgram[9] = 16'b0010_0010_0011_0000;  // R2 = R3
        // Opcode: 0010 (Copy)
        fibonacciProgram[10] = 16'b0010_0011_0110_0000;  // R3 = R6
        
        // Increment loop counter
        // Opcode: 0000 (Set to Constant)
        fibonacciProgram[11] = 16'b0000_0100_0000_0001;  // R4 = R4 + 1
        
        // Jump back to loop start
        // Opcode: 1101 (Jump)
        fibonacciProgram[12] = 16'b1101_0000_0000_0100;  // Jump to instruction 4
        
        // Check for overflow
        // Opcode: 0000 (Set to Constant)
        fibonacciProgram[13] = 16'b0000_0111_1111_1111;  // R7 = 255
        // Opcode: 1011 (Compare Greater Than)
        fibonacciProgram[14] = 16'b1011_1000_0011_0111;  // R8 = (R3 > 255)
        // Opcode: 0011 (Conditional Copy)
        fibonacciProgram[15] = 16'b0011_0011_0111_1000;  // R3 = 255 if overflow
        
        // Copy final result to output register
        // Opcode: 0010 (Copy)
        fibonacciProgram[16] = 16'b0010_1111_0011_0000;  // R15 = R3
        
        // Halt
        // Opcode: 1110 (Halt)
        fibonacciProgram[17] = 16'b1110_0000_0000_0000;  // HALT
    end

    reg [15:0] fourthProgram [0:127];
    initial begin
        // Load 5 into R1
        // After: R1 = 0000_0101 (5)
        fourthProgram[0] = 16'b0000_0001_0000_0101;  // Set R1 = 5
        fourthProgram[1] = 16'b0010_1111_0001_0000;  // Debug: Copy R1 to R15 to verify R1 = 5

        // Load 3 into R2
        // After: R2 = 0000_0011 (3)
        fourthProgram[2] = 16'b0000_0010_0000_0011;  // Set R2 = 3
        fourthProgram[3] = 16'b0010_1111_0010_0000;  // Debug: Copy R2 to R15 to verify R2 = 3

        // Copy R1 to R3
        // After: R3 = 0000_0101 (5)
        fourthProgram[4] = 16'b0010_0011_0001_0000;  // R3 = R1 (5)
        fourthProgram[5] = 16'b0010_1111_0011_0000;  // Debug: Copy R3 to R15 to verify R3 = 5

        // AND R1 and R2, store in R4
        // After: R4 = 0000_0001 (1) from 0101 & 0011
        fourthProgram[6] = 16'b0110_0100_0001_0010;  // R4 = R1 & R2 (1)
        fourthProgram[7] = 16'b0010_1111_0100_0000;  // Debug: Copy R4 to R15 to verify R4 = 1

        // OR R1 and R2, store in R5
        // After: R5 = 0000_0111 (7) from 0101 | 0011
        fourthProgram[8] = 16'b0111_0101_0001_0010;  // R5 = R1 | R2 (7)
        fourthProgram[9] = 16'b0010_1111_0101_0000;  // Debug: Copy R5 to R15 to verify R5 = 7

        // Compare R1 > R2, store in R6
        // After: R6 = 0000_0001 (1) since 5 > 3 is true
        fourthProgram[10] = 16'b1011_0110_0001_0010;  // R6 = R1 > R2 (1)
        fourthProgram[11] = 16'b0010_1111_0110_0000;  // Debug: Copy R6 to R15 to verify R6 = 1

        // Shift R1 left by 1, store in R7
        // After: R7 = 0000_1010 (10) from 0101 << 1
        fourthProgram[12] = 16'b1000_0111_0001_0000;  // R7 = R1 << 1 (10)
        fourthProgram[13] = 16'b0010_1111_0111_0000;  // Debug: Copy R7 to R15 to verify R7 = 10

        // Negate R2, store in R8
        // After: R8 = 1111_1101 (-3) 2's complement of 0011
        fourthProgram[14] = 16'b0101_1000_0010_0000;  // R8 = -R2 (-3)
        fourthProgram[15] = 16'b0010_1111_1000_0000;  // Debug: Copy R8 to R15 to verify R8 = -3

        // Add R7 and R8, store in R15
        // After: R15 = 0000_0111 (7) from 1010 + 11111101
        fourthProgram[16] = 16'b0100_1111_0111_1000;  // R15 = R7 + R8 (7)
        // No need for debug copy since result is already in R15

        // Halt
        fourthProgram[17] = 16'b1110_0000_0000_0000;
    end

    // Modified program selection logic with priority encoding
    wire [7:0] effectiveProgramSelect;
    
    // Priority encoder - select lowest numbered active switch
    assign effectiveProgramSelect[0] = programSelect[0];
    assign effectiveProgramSelect[1] = programSelect[1] & ~programSelect[0];
    assign effectiveProgramSelect[2] = programSelect[2] & ~programSelect[1] & ~programSelect[0];
    assign effectiveProgramSelect[3] = programSelect[3] & ~programSelect[2] & ~programSelect[1] & ~programSelect[0];
    assign effectiveProgramSelect[4] = programSelect[4] & ~programSelect[3] & ~programSelect[2] & ~programSelect[1] & ~programSelect[0];
    assign effectiveProgramSelect[5] = programSelect[5] & ~programSelect[4] & ~programSelect[3] & ~programSelect[2] & ~programSelect[1] & ~programSelect[0];
    assign effectiveProgramSelect[6] = programSelect[6] & ~programSelect[5] & ~programSelect[4] & ~programSelect[3] & ~programSelect[2] & ~programSelect[1] & ~programSelect[0];
    assign effectiveProgramSelect[7] = programSelect[7] & ~programSelect[6] & ~programSelect[5] & ~programSelect[4] & ~programSelect[3] & ~programSelect[2] & ~programSelect[1] & ~programSelect[0];
    

    assign instruction = 
        effectiveProgramSelect[0] ? sumIntegersProgram[address] :
        effectiveProgramSelect[1] ? squareOfNProgram[address] :
        effectiveProgramSelect[2] ? thirdProgram[address] :
        effectiveProgramSelect[3] ? fibonacciProgram[address] : 
        effectiveProgramSelect[4] ? fourthProgram[address] : 16'b0;

endmodule