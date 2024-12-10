/*
    Diego Bonilla, Enrique Macaya, Sebastian Lopez, Andres Antillon
    Project 1
    ECE 2372
    Dr. Juan Carlos Rojas
    Datapath module
*/

/*
    Datapath Module
    Inputs:
        clk: Clock signal
        writeEnable: Write enable signal
        writeSourceSelect: Selector between extInputData and ALU output
        muxBSelect: Selector for register B
        muxASelect: Selector for register A
        extInputData: Data to replace in the register
        destAddress: Selector for the register to replace
        aAddress: Selector for register A
        bAddress: Selector for register B
        aluOpCode: Operation selector
*/

module datapath(
    // Input control signals
    input clk,                    // Clock signal
    input rst,                    // Reset signal
    input writeEnable,           // Enables writing to register file when high
    input writeSourceSelect,     // Selects between extInputData (1) and ALU output (0) for register writes
    input muxBSelect,            // Selects between immediate value (1) and register B value (0)
    input muxASelect,            // Selects between immediate value (1) and register A value (0)
    
    // Input data signals
    input [7:0] extInputData,    // External input data for immediate values or I/O
    input [3:0] destAddress,     // Destination register address for write operations
    input [3:0] aAddress,        // Address of register A to read
    input [3:0] bAddress,        // Address of register B to read
    input [3:0] aluOpCode,       // Operation code for ALU
    input haltCondition,         // Halt condition for conditional halt
    
    // Output signals
    output [7:0] R15_out,        // Value of register 15, always exposed for monitoring
    output reg halt               // Output halt signal
);

    // Internal wires
    wire [7:0] regA;            // Value read from register A
    wire [7:0] regB;            // Value read from register B
    wire [7:0] aluZ;            // Result from ALU operation
    wire [7:0] replaceData;     // Data to be written to register file
    wire [7:0] aluA;            // A input to ALU
    wire [7:0] aluB;            // B input to ALU

    // Select data source for register writes
    assign replaceData = (writeSourceSelect) ? extInputData : aluZ;
    
    // Select A input for ALU
    assign aluA = muxASelect ? extInputData : regA;
    // Select B input for ALU
    assign aluB = muxBSelect ? extInputData : regB;

    register_file regFile(
        .clk(clk), 
        .rst(rst), 
        .replaceData(replaceData), 
        .replaceSel(destAddress), 
        .A_sel(aAddress), 
        .B_sel(bAddress), 
        .writeEnable(writeEnable), 
        .A(regA), 
        .B(regB),
        .R15_out(R15_out)
    );

    alu alu(
        .OP(aluOpCode), 
        .A(aluA), 
        .B(aluB),
        .Z(aluZ)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            halt <= 1'b0;  // Reset halt signal
        end else if (haltCondition) begin
            // Check the value of the register at aAddress
            if (regA == 8'b00000000) begin
                halt <= 1'b1;  // Halt if the register value is zero
            end else begin
                halt <= 1'b0;  // Continue if the register value is non-zero
            end
        end
    end

endmodule
