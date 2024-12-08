module instructionMemory (
    input wire [7:0] address,
    input wire [7:0] programSelect,
    output wire [15:0] instruction
);
    //Program 1: Sum integers from 1 to N  
    //Instructions for Program 1 
    // Step # | Instruction | Binary (16-bit) | Hex | Description |
    // Step 1 | INPUT → R1 | 0001_0001_0000_0000 | 0x1100 | Load external input (N) into R1 |
    // Step 2 | R2 ← 1 | 0000_0010_0000_0001 | 0x0201 | Initialize counter (R2) with 1 |
    // Step 3 | R3 ← 0 | 0000_0011_0000_0000 | 0x0300 | Initialize sum (R3) with 0 |
    // Step 4 | R3 ← R3 + R2 | 0100_0011_0011_0010 | 0x4332 | Add counter to sum |
    // Step 5 | R4 ← 255 | 0000_0100_1111_1111 | 0x04FF | Load max value (255) into R4 |
    // Step 6 | R5 ← (R3 > R4) | 1011_0101_0011_0100 | 0xB534 | Compare if sum > 255 |
    // Step 7 | IF R5 JUMP +1 | 1100_0000_0101_0001 | 0xC051 | If overflow, jump to cap value |
    // Step 8 | JUMP +1 | 0010_0000_0000_0001 | 0x2001 | Skip cap instruction |
    // Step 9 | R3 ← 255 | 0010_0011_1111_1111 | 0x2340 | Cap sum at 255 |
    // Step 10 | R2 ← R2 + 1 | 0100_0010_0010_0001 | 0x4226 | Increment counter |
    // Step 11 | R4 ← (R2 > R1) | 1011_0100_0010_0001 | 0xB421 | Check if counter > N |
    // Step 12 | IF R4 JUMP +2 | 1100_0000_0100_0010 | 0xC042 | If done, exit loop |
    // Step 13 | JUMP -10 | 0010_0000_1111_1101 | 0x2003 | Jump back to loop start |
    // Step 14 | R15 ← R3 | 0010_1111_0011_0000 | 0x2F30 | Copy result to output register |
    // Step 15 | HALT | 1110_0000_0000_0000 | 0xE000 | Stop program execution |

        //Program 1: Sum integers from 1 to N   
    reg [15:0] sumIntegersProgram [0:127];
    initial begin
        // 1. Load N from external input into R1
        sumIntegersProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT

        // 2. Initialize counter (R2) with 1
        sumIntegersProgram[1] = 16'b0000_0010_0000_0001;  // R2 = 1

        // 3. Initialize sum (R3) with 0
        sumIntegersProgram[2] = 16'b0000_0011_0000_0000;  // R3 = 0

        // 4. LOOP START: Add current counter to sum
        sumIntegersProgram[3] = 16'b0100_0011_0011_0010;  // R3 = R3 + R2

        // 5. Check for overflow (R3 > 255)
        sumIntegersProgram[4] = 16'b0000_0100_1111_1111;  // R4 = 255
        sumIntegersProgram[5] = 16'b1011_0101_0011_0100;  // R5 = (R3 > R4)
        sumIntegersProgram[6] = 16'b1100_0000_0101_0001;  // If R5=1, jump to cap value
        sumIntegersProgram[7] = 16'b0010_0000_0000_0001;  // Skip next instruction
        sumIntegersProgram[8] = 16'b0000_0011_1111_1111;  // R3 = 255 (cap value) - Changed to immediate load

        // 6. Increment counter
        sumIntegersProgram[9] = 16'b0100_0010_0010_0001;  // R2 = R2 + 1 - Fixed increment

        // 7. Compare counter with N
        sumIntegersProgram[10] = 16'b1011_0100_0010_0001;  // R4 = (R2 > R1)
        sumIntegersProgram[11] = 16'b1100_0000_0100_0010;  // If R4=1, exit loop
        sumIntegersProgram[12] = 16'b0010_0000_1111_1101;  // Jump back to instruction 3 - Fixed jump offset

        // 8. Copy result to output
        sumIntegersProgram[13] = 16'b0010_1111_0011_0000;  // R15 = R3

        // 9. Halt
        sumIntegersProgram[14] = 16'b1110_0000_0000_0000;  // HALT
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
    initial begin
        //| Step | Instruction | Binary (16-bit) | Hex | Description |
        //| 1 | INPUT → R1 | 0001_0001_0000_0000 | 0x1100 | Load external input (N) into R1 |
        squareOfNProgram[0] = 16'b0001_0001_0000_0000; // R1 = INPUT

        //| 2 | R2 ← R1 | 0000_0010_0000_0001 | 0x0201 | Copy input (R1) into R2 |
        squareOfNProgram[1] = 16'b0000_0010_0000_0001; // R2 = R1

        //| 3 | R3 ← R1 * R2 | 0011_0011_0010_0000 | 0x3320 | Square input (N) |
        squareOfNProgram[2] = 16'b0011_0011_0010_0000; // R3 = R1 * R2

        //| 4 | R4 ← 255 | 0000_0100_1111_1111 | 0x04FF | Load maximum value (255) into R4 |
        squareOfNProgram[3] = 16'b0000_0100_1111_1111; // R4 = 255

        //| 5 | R5 ← (R3 > R4) | 1011_0101_0011_0100 | 0xB534 | Compare square result to 255 |
        squareOfNProgram[4] = 16'b1011_0101_0011_0100; // R5 = (R3 > R4)

        //| 6 | IF R5 JUMP +1 | 1100_0000_0000_0001 | 0xC001 | If R3 > R4, jump to cap |
        squareOfNProgram[5] = 16'b1100_0000_0000_0001; // If overflow, jump

        //| 7 | R3 ← 255 | 0010_0011_0100_0000 | 0x2340 | Cap square result at 255 |
        squareOfNProgram[6] = 16'b0010_0011_0100_0000; // R3 = 255

        //| 8 | R6 ← R3 | 0010_1110_0011_0000 | 0x2E30 | Copy final result to R6 |
        squareOfNProgram[7] = 16'b0010_1110_0011_0000; // R6 = R3

        //| 9 | HALT | 1110_0000_0000_0000 | 0xE000 | End program |
        squareOfNProgram[8] = 16'b1110_0000_0000_0000; // HALT
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

        // Halt execution
        // Opcode: 1110 (HALT)
        thirdProgram[5] = 16'b1110_0000_0000_0000;
    end

    // Program 4: Calculate Fibonacci sequence
    // Instruction Format:
    // 16-bit instruction: [15:12] opcode | [11:8] dest_reg | [7:4] src1_reg | [3:0] src2_reg/immediate
    // Common Opcodes:
    // 0000 = Set Register to Constant
    // 0001 = Load from External Input
    // 0010 = Copy Register/Jump
    // 0100 = Add
    // 0101 = Negate
    // 1011 = Compare Greater Than
    // 1100 = Conditional Jump
    // 1110 = Halt
    // Register usage:
    // R1: Number of iterations (N)
    // R2: Previous number (F(n-2))
    // R3: Current number (F(n-1))
    // R4: Next number in sequence (F(n))
    // R5: Loop counter
    // R6: Used for overflow comparison (255)
    // R7: Temporary comparison results
    // R15: Output register
    reg [15:0] fourthProgram [0:127];
    initial begin
        // Load number of iterations from external input into R1
        // Opcode: 0001 (Load External) | Dest: 0001 (R1) | Src: 0000 | Immediate: 0000
        fourthProgram[0] = 16'b0001_0001_0000_0000;  // R1 = Input

        // Initialize F(0) = 0 in R2
        // Opcode: 0000 (Set Constant) | Dest: 0010 (R2) | Value: 0000_0000
        fourthProgram[1] = 16'b0000_0010_0000_0000;  

        // Initialize F(1) = 1 in R3
        // Opcode: 0000 (Set Constant) | Dest: 0011 (R3) | Value: 0000_0001
        fourthProgram[2] = 16'b0000_0011_0000_0001;  

        // Initialize counter R5 = 2 (we already have F(0) and F(1))
        // Opcode: 0000 (Set Constant) | Dest: 0101 (R5) | Value: 0000_0010
        fourthProgram[3] = 16'b0000_0101_0000_0010;  

        // Load max value (255) into R6 for overflow checking
        // Opcode: 0000 (Set Constant) | Dest: 0110 (R6) | Value: 1111_1111
        fourthProgram[4] = 16'b0000_0110_1111_1111;  

        // LOOP START - Calculate next Fibonacci number
        // R4 = R2 + R3 (Next = Previous + Current)
        // Opcode: 0100 (Add) | Dest: 0100 (R4) | Src1: 0010 (R2) | Src2: 0011 (R3)
        fourthProgram[5] = 16'b0100_0100_0010_0011;  

        // Check for overflow: Compare R4 with max value (255)
        // Opcode: 1011 (Compare >) | Dest: 0111 (R7) | Src1: 0100 (R4) | Src2: 0110 (R6)
        fourthProgram[6] = 16'b1011_0111_0100_0110;  // R7 = (R4 > R6)

        // If overflow detected, jump to end with max value
        // Opcode: 1100 (Cond Jump) | Cond: 0000 | Src: 0111 (R7) | Offset: 0110 (+6)
        fourthProgram[7] = 16'b1100_0000_0111_0110;  // If R7 = 1, jump +6 to max value

        // No overflow - continue sequence
        // Update previous (R2 = R3)
        // Opcode: 0010 (Copy) | Dest: 0010 (R2) | Src: 0011 (R3) | Unused: 0000
        fourthProgram[8] = 16'b0010_0010_0011_0000;  

        // Update current (R3 = R4)
        // Opcode: 0010 (Copy) | Dest: 0011 (R3) | Src: 0100 (R4) | Unused: 0000
        fourthProgram[9] = 16'b0010_0011_0100_0000;  

        // Increment counter (R5 = R5 + 1)
        // Opcode: 0100 (Add) | Dest: 0101 (R5) | Src1: 0101 (R5) | Src2: 0110 (1)
        fourthProgram[10] = 16'b0100_0101_0101_0110;  

        // Compare counter with N (R7 = R5 > R1)
        // Opcode: 1011 (Compare >) | Dest: 0111 (R7) | Src1: 0101 (R5) | Src2: 0001 (R1)
        fourthProgram[11] = 16'b1011_0111_0101_0001;  

        // If counter <= N, continue loop
        // Opcode: 1100 (Cond Jump) | Cond: 0000 | Src: 0111 (R7) | Offset: 0010 (+2)
        fourthProgram[12] = 16'b1100_0000_0111_0010;  

        // Jump back to loop start
        // Opcode: 0010 (Jump) | Unused: 0000 | Offset: 1000 (-8)
        fourthProgram[13] = 16'b0010_0000_0000_1000;  

        // Store result in R15 (normal case)
        // Opcode: 0010 (Copy) | Dest: 1111 (R15) | Src: 0011 (R3) | Unused: 0000
        fourthProgram[14] = 16'b0010_1111_0011_0000;  // R15 = R3

        // Jump to end
        // Opcode: 0010 (Jump) | Unused: 0000 | Offset: 0001 (+1)
        fourthProgram[15] = 16'b0010_0000_0000_0001;  // Jump +1

        // Overflow case - store max value (255) in R15
        // Opcode: 0010 (Copy) | Dest: 1111 (R15) | Src: 0110 (R6) | Unused: 0000
        fourthProgram[16] = 16'b0010_1111_0110_0000;  // R15 = R6 (225)

        // Halt
        // Opcode: 1110 (Halt) | Unused: 0000_0000_0000
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
        effectiveProgramSelect[3] ? fourthProgram[address] : 16'b0;

endmodule