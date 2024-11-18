module instructionDecoder (
    // Input signals
    input wire [15:0] instruction,     // Current instruction to decode
    input wire [1:0] programSelect,    // Selects which program to execute
    input wire clk,                    // Clock signal
    input wire rst,                    // Reset signal, sets PC to 0
    input wire [7:0] extInputDataSW,     // Add this new input
    
    // Output control signals
    output reg [7:0] instructionAddress,  // Program Counter - Address of next instruction
    output reg [3:0] destAddress,         // Destination register address for write operations
    output reg [3:0] bAddress,            // Address of register B to read
    output reg [3:0] aAddress,            // Address of register A to read
    output reg writeSourceSelect,         // Selects between extInputData (1) and ALU output (0) for register writes
    output reg muxBSelect,                // Selects between immediate value (1) and register B value (0)
    output reg muxASelect,                // Selects between immediate value (1) and register A value (0)
    output reg [3:0] aluOpCode,          // Operation code for ALU
    output reg writeEnable,               // Enables writing to register file when high
    output reg halt,                     // Halts the program when high
    output reg [7:0] selectedInputData   // Add this new output
);

    // Program Counter
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instructionAddress <= 8'b0;
        end else if (!halt) begin
            instructionAddress <= instructionAddress + 1;
        end
    end

    // Instruction Format from ISA:
    // [15:12] - OpCode (4 bits)
    // [11:8]  - Destination Register (Dst Reg Idx)
    // [7:4]   - Operand 2 (Value upper 4 bits or Src Reg Idx)
    // [3:0]   - Operand 3 (Value lower 4 bits or Cond Reg Idx)

    always @(*) begin
        // Default values
        destAddress = instruction[11:8];  // Destination register is always bits [11:8]
        bAddress = instruction[7:4];      // Source register B or upper bits of immediate
        aAddress = instruction[3:0];      // Source register A or lower bits of immediate
        muxBSelect = 1'b0;               // Default: use register value
        muxASelect = 1'b0;               // Default: use register value
        writeSourceSelect = 1'b0;        // Default: use ALU output
        writeEnable = 1'b1;              // Default: enable register write
        aluOpCode = 4'b0000;             // Default: pass A
        halt = 1'b0;                     // Default: continue execution

        // Form 8-bit immediate value from instruction operands
        selectedInputData = {instruction[7:4], instruction[3:0]};  // Default to immediate value

        case(instruction[15:12])  // OpCode
            4'b0000: begin  // Set to Constant
                writeSourceSelect = 1'b1;  // Select immediate value
                muxBSelect = 1'b1;        // Use immediate value from instruction
                // Value is formed by concatenating Operand 2 and 3
            end
            
            4'b0001: begin  // Load External
                writeSourceSelect = 1'b1;  // Select external input
                selectedInputData = extInputDataSW;
            end
            
            4'b0010: begin  // Copy
                aluOpCode = 4'b0001;  // Pass B through ALU
                // bAddress already set to source register index
            end
            
            4'b0011: begin  // Conditional Copy
                // TODO: Implement condition checking
                // Need to:
                // 1. Read value from condition register (aAddress)
                // 2. Set writeEnable based on condition != 0
                aluOpCode = 4'b0001;
            end
            
            4'b0100: begin  // Add
                aluOpCode = 4'b0010;  // Add operation
                // Both source registers are used for operation
            end
            
            4'b0101: begin  // Negate
                aluOpCode = 4'b0011;  // Negate operation
                // Only source register B is used
            end
            
            4'b0110: begin  // AND
                aluOpCode = 4'b0100;  // AND operation
                // Both source registers are used
            end
            
            4'b0111: begin  // OR
                aluOpCode = 4'b0101;  // OR operation
                // Both source registers are used
            end
            
            4'b1000: begin  // Shift Left
                // Value = [3:0] (shift amount)
                aluOpCode = 4'b0110;  // Shift left operation
                muxBSelect = 1'b1;    // Use immediate value for shift amount
                // Lower 4 bits contain shift amount
            end
            
            4'b1001: begin  // Shift Right
                // Value = [3:0] (shift amount)
                aluOpCode = 4'b0111;  // Shift right operation
                muxBSelect = 1'b1;    // Use immediate value for shift amount
                // Lower 4 bits contain shift amount
            end
            
            4'b1010: begin  // Equals
                aluOpCode = 4'b1000;  // Equals comparison
                // Result will be 1 if equal, 0 if not
            end
            
            4'b1011: begin  // Greater Than
                aluOpCode = 4'b1001;  // Greater than comparison
                // Result will be 1 if A > B, 0 if not
            end
            
            4'b1110: begin  // Unconditional Halt
                // No registers used
                halt = 1'b1;          // Stop program execution
                writeEnable = 1'b0;   // Prevent register writes
            end
            
            4'b1111: begin  // Conditional Halt
                // TODO: Implement condition checking
                // Need to:
                // 1. Read value from condition register (aAddress)
                // 2. Set halt based on condition != 0
                writeEnable = 1'b0;   // Prevent register writes
            end
            
            default: begin
                writeEnable = 1'b0;
                halt = 1'b0;
            end
        endcase
    end

endmodule