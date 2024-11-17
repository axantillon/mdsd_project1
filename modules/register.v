/*
    Diego Bonilla, Enrique Macaya, Sebastian Lopez, Andres Antillon
    Project 1
    ECE 2372
    Dr. Juan Carlos Rojas
    Register module
*/

/*
    Register File Module
    Inputs:
        clk: Clock signal
        replaceData: Data to replace in the register
        replaceSel: Selector for the register to replace
        A_sel: Selector for register A
        B_sel: Selector for register B
        writeEnable: Enable signal for writing
    Outputs:
        A: Value passed to A
        B: Value passed to B
        R15_out: Value of register 15
*/

module register_file(
    input clk, 
    input [7:0] replaceData, 
    input [3:0] replaceSel, 
    input [3:0] A_sel, 
    input [3:0] B_sel,
    input writeEnable, 
    output [7:0] A, 
    output [7:0] B,
    output [7:0] R15_out
);

    reg [7:0] regs[15:0];

    initial begin
        integer i;
        for (i = 0; i < 16; i = i + 1) begin
            regs[i] = 8'b0;
        end
    end

    always @(posedge clk) begin
        if (writeEnable)
            regs[replaceSel] <= replaceData;
    end

    assign A = regs[A_sel];
    assign B = regs[B_sel];
    assign R15_out = regs[15];

endmodule