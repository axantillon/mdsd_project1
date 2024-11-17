/*
    Diego Bonilla, Enrique Macaya, Sebastian Lopez, Andres Antillon
    Project 1
    ECE 2372
    Dr. Juan Carlos Rojas
    AlU module
*/

/*
    ALU Module
    OP: Operation code
    A: First operand
    B: Second operand
    Z: Result
*/
module alu(
    input [3:0] OP, 
    input [7:0] A, 
    input [7:0] B, 
    output reg [7:0] Z
);

    always @(*) begin  // Use @(*) instead of explicit sensitivity list
        case (OP)
            // Pass through operations
            4'b0000: Z = A;           // Pass A
            4'b0001: Z = B;           // Pass B
            
            // Arithmetic operations
            4'b0010: Z = A + B;       // Add
            4'b0011: Z = ~A + 1;      // Negate A (2's complement)
            
            // Logical operations
            4'b0100: Z = A & B;       // AND
            4'b0101: Z = A | B;       // OR
            
            // Shift operations
            4'b0110: Z = A << B;      // Shift Left
            4'b0111: Z = A >> B;      // Shift Right
            
            // Comparison operations
            4'b1000: Z = (A == B) ? 8'b1 : 8'b0;    // Equals
            4'b1001: Z = (A > B) ? 8'b1 : 8'b0;     // Greater Than
            
            // Constants
            4'b1111: Z = B;           // Used for Set to Constant

            default: Z = 8'b0;
        endcase
    end

endmodule