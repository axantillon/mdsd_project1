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
        // Load N from input
        sumIntegersProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT
        
        // Initialize sum register
        sumIntegersProgram[1] = 16'b0000_0010_0000_0000;  // R2 = 0 (sum)
        
        // Add 1
        sumIntegersProgram[2] = 16'b0000_0011_0000_0001;  // R3 = 1
        sumIntegersProgram[3] = 16'b0100_0010_0010_0011;  // R2 = R2 + R3
        
        // Add 2 if N >= 2
        sumIntegersProgram[4] = 16'b0000_0011_0000_0010;  // R3 = 2
        sumIntegersProgram[5] = 16'b1011_0100_0001_0011;  // R4 = (N >= 2)
        sumIntegersProgram[6] = 16'b0011_0101_0010_0011;  // R5 = R2 + R3 (conditional sum)
        sumIntegersProgram[7] = 16'b0011_0010_0101_0100;  // R2 = R5 if N>=2

        // Add 3 if N >= 3
        sumIntegersProgram[8] = 16'b0000_0011_0000_0011;  // R3 = 3
        sumIntegersProgram[9] = 16'b1011_0100_0001_0011;  // R4 = (N >= 3)
        sumIntegersProgram[10] = 16'b0011_0101_0010_0011;  // R5 = R2 + R3
        sumIntegersProgram[11] = 16'b0011_0010_0101_0100;  // R2 = R5 if N>=3

        // Add 4 if N >= 4
        sumIntegersProgram[12] = 16'b0000_0011_0000_0100;  // R3 = 4
        sumIntegersProgram[13] = 16'b1011_0100_0001_0011;  // R4 = (N >= 4)
        sumIntegersProgram[14] = 16'b0011_0101_0010_0011;  // R5 = R2 + R3
        sumIntegersProgram[15] = 16'b0011_0010_0101_0100;  // R2 = R5 if N>=4

        // Copy final result to output
        sumIntegersProgram[16] = 16'b0010_1111_0010_0000;  // R15 = R2

        // Halt
        sumIntegersProgram[17] = 16'b1110_0000_0000_0000;  // HALT
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
        squareOfNProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT
        
        // Initialize result register
        squareOfNProgram[1] = 16'b0000_0010_0000_0000;  // R2 = 0 (result)

        // First addition (always happens)
        squareOfNProgram[2] = 16'b0100_0010_0010_0001;  // R2 = R2 + R1

        // Second addition (if N >= 2)
        squareOfNProgram[3] = 16'b0000_0011_0000_0010;  // R3 = 2
        squareOfNProgram[4] = 16'b1011_0100_0001_0011;  // R4 = (N >= 2)
        squareOfNProgram[5] = 16'b0011_0101_0010_0001;  // R5 = R2 + R1
        squareOfNProgram[6] = 16'b0011_0010_0101_0100;  // R2 = R5 if N>=2

        // Third addition (if N >= 3)
        squareOfNProgram[7] = 16'b0000_0011_0000_0011;  // R3 = 3
        squareOfNProgram[8] = 16'b1011_0100_0001_0011;  // R4 = (N >= 3)
        squareOfNProgram[9] = 16'b0011_0101_0010_0001;  // R5 = R2 + R1
        squareOfNProgram[10] = 16'b0011_0010_0101_0100;  // R2 = R5 if N>=3

        // Fourth addition (if N >= 4)
        squareOfNProgram[11] = 16'b0000_0011_0000_0100;  // R3 = 4
        squareOfNProgram[12] = 16'b1011_0100_0001_0011;  // R4 = (N >= 4)
        squareOfNProgram[13] = 16'b0011_0101_0010_0001;  // R5 = R2 + R1
        squareOfNProgram[14] = 16'b0011_0010_0101_0100;  // R2 = R5 if N>=4

        // Check for overflow (>255)
        squareOfNProgram[15] = 16'b0000_0011_1111_1111;  // R3 = 255
        squareOfNProgram[16] = 16'b1011_0100_0010_0011;  // R4 = (result > 255)
        squareOfNProgram[17] = 16'b0011_0101_0011_0100;  // R5 = 255 if overflow
        squareOfNProgram[18] = 16'b0011_0010_0101_0100;  // R2 = R5 if overflow

        // Copy to output
        squareOfNProgram[19] = 16'b0010_1111_0010_0000;  // R15 = R2

        // Halt
        squareOfNProgram[20] = 16'b1110_0000_0000_0000;  // HALT
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
        // Load N from input
        fourthProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT
        
        // Initialize first two numbers
        fourthProgram[1] = 16'b0000_0010_0000_0000;  // R2 = 0 (F0)
        fourthProgram[2] = 16'b0000_0011_0000_0001;  // R3 = 1 (F1)
        
        // First number is 1 if N >= 1
        fourthProgram[3] = 16'b0000_0100_0000_0001;  // R4 = 1
        fourthProgram[4] = 16'b1011_0101_0001_0100;  // R5 = (N >= 1)
        fourthProgram[5] = 16'b0011_0110_0011_0101;  // R6 = R3 if N>=1
        
        // Second number (1) if N >= 2
        fourthProgram[6] = 16'b0100_0111_0010_0011;  // R7 = F0 + F1
        fourthProgram[7] = 16'b0000_0100_0000_0010;  // R4 = 2
        fourthProgram[8] = 16'b1011_0101_0001_0100;  // R5 = (N >= 2)
        fourthProgram[9] = 16'b0011_0110_0111_0101;  // R6 = R7 if N>=2
        
        // Third number (2) if N >= 3
        fourthProgram[10] = 16'b0100_0111_0011_0110;  // R7 = F1 + F2
        fourthProgram[11] = 16'b0000_0100_0000_0011;  // R4 = 3
        fourthProgram[12] = 16'b1011_0101_0001_0100;  // R5 = (N >= 3)
        fourthProgram[13] = 16'b0011_0110_0111_0101;  // R6 = R7 if N>=3
        
        // Fourth number (3) if N >= 4
        fourthProgram[14] = 16'b0100_0111_0110_0011;  // R7 = F2 + F3
        fourthProgram[15] = 16'b0000_0100_0000_0100;  // R4 = 4
        fourthProgram[16] = 16'b1011_0101_0001_0100;  // R5 = (N >= 4)
        fourthProgram[17] = 16'b0011_0110_0111_0101;  // R6 = R7 if N>=4

        // Check for overflow
        fourthProgram[18] = 16'b0000_0100_1111_1111;  // R4 = 255
        fourthProgram[19] = 16'b1011_0101_0110_0100;  // R5 = (result > 255)
        fourthProgram[20] = 16'b0011_0111_0100_0101;  // R7 = 255 if overflow
        fourthProgram[21] = 16'b0011_0110_0111_0101;  // R6 = R7 if overflow

        // Copy to output
        fourthProgram[22] = 16'b0010_1111_0110_0000;  // R15 = R6

        // Halt
        fourthProgram[23] = 16'b1110_0000_0000_0000;  // HALT
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