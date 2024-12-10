module instructionMemory (
    input wire [7:0] address,
    input wire [7:0] programSelect,
    output wire [15:0] instruction
);
    //Program 1: Sum integers from 1 to N  
    //Instructions for Program 1 
    //| Step | Instruction | Binary (16-bit) | Hex | Description |
    // | 1 | INPUT → R1 | 0001_0001_0000_0000 | 0x1100 | Load external input (N) into R1 |
    //| 2 | R2 ← 1 | 0000_0010_0000_0001 | 0x0201 | Initialize counter (R2) with 1 |
    //| 3 | R3 ← 0 | 0000_0011_0000_0000 | 0x0300 | Initialize sum (R3) with 0 |
    //| 4 | R3 ← R3 + R2 | 0100_0011_0011_0010 | 0x4332 | Add counter to sum |
    //| 5 | R4 ← 255 | 0000_0100_1111_1111 | 0x04FF | Load max value (255) into R4 |
    //| 6 | R5 ← (R3 > R4) | 1011_0101_0011_0100 | 0xB534 | Compare if sum > 255 |
    //| 7 | IF R5 JUMP +1 | 1100_0000_0101_0001 | 0xC051 | If overflow, jump to cap value |
    //| 8 | JUMP +1 | 0010_0000_0000_0001 | 0x2001 | Skip cap instruction |
    //| 9 | R3 ← 255 | 0010_0011_0100_0000 | 0x2340 | Cap sum at 255 |
    //| 10 | R2 ← R2 + 1 | 0100_0010_0010_0110 | 0x4226 | Increment counter |
    //| 11 | R4 ← (R2 > R1) | 1011_0100_0010_0001 | 0xB421 | Check if counter > N |
    //| 12 | IF R4 JUMP +2 | 1100_0000_0100_0010 | 0xC042 | If done, exit loop |
    //| 13 | JUMP -10 | 0010_0000_0000_0011 | 0x2003 | Jump back to loop start |
    //| 14 | R15 ← R3 | 0010_1111_0011_0000 | 0x2F30 | Copy result to output register |
    //| 15 | HALT | 1110_0000_0000_0000 | 0xE000 | Stop program execution |

    //Program 1: Sum integers from 1 to N   
    initial begin
        // 1. Load N from external input into R1 (N will be 4 bits: 0-15)
        sumIntegersProgram[0] = 16'b0001_0001_0000_0000;  // R1 = INPUT

        // 2. Initialize counter (R2) with 1
        sumIntegersProgram[1] = 16'b0000_0010_0000_0001;  // R2 = 1

        // 3. Initialize sum (R3) with 0
        sumIntegersProgram[2] = 16'b0000_0011_0000_0000;  // R3 = 0

        // 4. LOOP START: Add current counter to sum
        // R3 = R3 + R2
        sumIntegersProgram[3] = 16'b0100_0011_0011_0010;  // R3 += R2

        // 5. Check if sum > 255 (maximum allowed value)
        sumIntegersProgram[4] = 16'b0000_0100_1111_1111;  // R4 = 255 (load max value)
        sumIntegersProgram[5] = 16'b1011_0101_0011_0100;  // R5 = (R3 > R4)
        sumIntegersProgram[6] = 16'b1100_0000_0101_0001;  // If R5=1, jump to cap value (instruction 8)
        sumIntegersProgram[7] = 16'b0010_0000_0000_0001;  // Skip next instruction
        sumIntegersProgram[8] = 16'b0010_0011_0100_0000;  // R3 = 255 (cap the value)

        // 6. Increment counter
        sumIntegersProgram[9] = 16'b0100_0010_0010_0110;  // R2 = R2 + 1

        // 7. Check if counter <= N
        sumIntegersProgram[10] = 16'b1011_0100_0010_0001;  // R4 = (R2 > R1)
        sumIntegersProgram[11] = 16'b1100_0000_0100_0010;  // If R4=1, exit loop
        sumIntegersProgram[12] = 16'b0010_0000_0000_0011;  // Jump back to loop start

        // 8. Store final result in R15 for output
        sumIntegersProgram[13] = 16'b0010_1111_0011_0000;  // R15 = R3

        // 9. Halt program
        sumIntegersProgram[14] = 16'b1110_0000_0000_0000;  // HALT
    end

    reg [15:0] squareOfNProgram [0:127];
    initial begin
        squareOfNProgram[0] = 16'b0010000000000001;
        squareOfNProgram[1] = 16'b0010000000000010;
        squareOfNProgram[2] = 16'b0010000000000011;
        squareOfNProgram[3] = 16'b0010000000000100;
        squareOfNProgram[4] = 16'b0010000000000101;
        squareOfNProgram[5] = 16'b0010000000000110;
        squareOfNProgram[6] = 16'b0010000000000111;
        squareOfNProgram[7] = 16'b0010000000001000;
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

    // Program 4: Test multiple operations
    // Expected register values after each instruction:
    // R1 = 5     (0000_0101)
    // R2 = 3     (0000_0011)
    // R3 = 5     (0000_0101) copied from R1
    // R4 = 1     (0000_0001) from 5 AND 3  (0101 & 0011)
    // R5 = 7     (0000_0111) from 5 OR 3   (0101 | 0011)
    // R6 = 1     (0000_0001) from 5 > 3    (true)
    // R7 = 10    (0000_1010) from 5 << 1   (0101 << 1)
    // R8 = -3    (1111_1101) from NEG 3    (2's complement of 0011)
    // R15 = 7    (0000_0111) from 10 + -3  (1010 + 11111101)
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
        effectiveProgramSelect[3] ? fourthProgram[address] : 16'b0;

endmodule