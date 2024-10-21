/*
    Diego Bonilla, Enrique Macaya, Sebastian Lopez, Andres Antillon
    Project 1
    ECE 2372
    Dr. Juan Carlos Rojas
    AlU module
*/


module custom_alu(input OP[0:3], input A[0:7], input B[0:7], output Z[0:7]);

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
            4'b0101: Z = ~A + 1; //TODO: Check if this is correct

            // Bitwise AND
            4'b0110: Z = A & B;

            // Bitwise OR
            4'b0111: Z = A | B;

            // Equals
            4'b1000: Z = A == B;

            // Greater than
            4'b1001: Z = A > B;

            default: Z = 8'b00000000;
        endcase
    end

endmodule