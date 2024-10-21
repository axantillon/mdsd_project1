/*
    Diego Bonilla, Enrique Macaya, Sebastian Lopez, Andres Antillon
    Project 1
    ECE 2372
    Dr. Juan Carlos Rojas
    Register module
*/


module register_file(
    input clk, 
    input [0:7] replaceData, 
    input [0:3] replaceSel, 
    input [0:3] A_sel, 
    input [0:3] B_sel, 
    output [0:7] A, 
    output [0:7] B
);

    reg [0:7] regs[0:15];

    always @(posedge clk) begin
        regs[replaceSel] <= replaceData;
    end

    always @(A_sel) begin
        A <= regs[A_sel];
    end

    always @(B_sel) begin
        B <= regs[B_sel];
    end

endmodule