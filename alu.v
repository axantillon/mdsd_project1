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
module alu(input [3:0] OP, input [7:0] A, input [7:0] B, output reg [7:0] Z);

    always @(OP, A, B) begin
        case (OP)
            // Zero
            4'b0000: Z = 8'b00000000;

            // One
            4'b0001: Z = 8'b00000001;

            // A
            4'b0010: Z = A;

            // B
            4'b0011: Z = B;

            // Add
            4'b0100: Z = A + B;

            // Negate A to Twos complement
            4'b0101: Z = ~A + 1;

            // Bitwise AND
            4'b0110: Z = A & B;

            // Bitwise OR
            4'b0111: Z = A | B;

            // Equals
            4'b1000: begin
                if (A == B)
                    Z = 8'b00000001;
                else
                    Z = 8'b00000000;
            end

            // Greater than
            4'b1001: begin
                if (A > B)
                    Z = 8'b00000001;
                else
                    Z = 8'b00000000;
            end

            default: Z = 8'b00000000;
        endcase
    end

endmodule