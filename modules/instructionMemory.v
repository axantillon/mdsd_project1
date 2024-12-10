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
    reg [15:0] sumIntegersProgram [0:127];
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

    // Program 4: Calculate Fibonacci Sequence
    // Expected register values after each instruction:
    // R1 = Number of iterations (N)
    // R2 = Previous number (F(n-2))
    // R3 = Current number (F(n-1))
    // R4 = Next number in sequence (F(n))
    // R5 = Loop counter
    // R6 = Used for overflow comparison
    // R15 = Final result
    reg [15:0] fourthProgram [0:127];
    initial begin
        // Load number of iterations into R1 (from input)
        fourthProgram[0] = 16'b0001_0001_0000_0000;  // R1 = Input

        //Initialize first two Fibonacci numbers
        // R2 = 0 (F(0))
        fourthProgram[1] = 16'b0000_0010_0000_0000;  

        // R3 = 1 (F(1))
        fourthProgram[2] = 16'b0000_0011_0000_0001;  

        // Initialize counter R5 = 2 (we already have F(0) and F(1))
        fourthProgram[3] = 16'b0000_0101_0000_0010;  

        // Load max value (255) into R6 for overflow checking
        fourthProgram[4] = 16'b0000_0110_1111_1111;  

        // LOOP START - Calculate next Fibonacci number
        // R4 = R2 + R3 (Next = Previous + Current)
        fourthProgram[5] = 16'b0100_0100_0010_0011;  

        // Check for overflow: Compare R4 with max value (255)
        fourthProgram[6] = 16'b1011_0111_0100_0110;  // R7 = (R4 > R6)

        // If overflow detected, jump to end with max value
        fourthProgram[7] = 16'b1100_0000_0111_0110;  // If R7 = 1, jump +6 to max value

        // No overflow - continue sequence
        // Update previous (R2 = R3)
        fourthProgram[8] = 16'b0010_0010_0011_0000;  

        // Update current (R3 = R4)
        fourthProgram[9] = 16'b0010_0011_0100_0000;  

        // Increment counter (R5 = R5 + 1)
        fourthProgram[10] = 16'b0100_0101_0101_0110;  

        // Compare counter with N (R7 = R5 > R1)
        fourthProgram[11] = 16'b1011_0111_0101_0001;  

        // If counter <= N, continue loop
        fourthProgram[12] = 16'b1100_0000_0111_0010;  

        // Jump back to loop start
        fourthProgram[13] = 16'b0010_0000_0000_1000;  

        // Store result in R15 (normal case)
        fourthProgram[14] = 16'b0010_1111_0011_0000;  // R15 = R3

        // Jump to end
        fourthProgram[15] = 16'b0010_0000_0000_0001;  // Jump +1

        // Overflow case - store max value (255) in R15
        fourthProgram[16] = 16'b0010_1111_0110_0000;  // R15 = R6 (225)

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