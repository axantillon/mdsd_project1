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
        muxSel: Selector between new input data and ALU output
        inputData: Data to replace in the register
        dstSel: Selector for the register to replace
        A_sel: Selector for register A
        B_sel: Selector for register B
        OP_Sel: Operation selector
*/

module datapath(
    input clk, writeEnable, muxSel,
    input [7:0] inputData,
    input [3:0] dstSel,
    input [3:0] A_sel,
    input [3:0] B_sel,
    input [3:0] OP_Sel
);

    wire replaceData, clk_writeEnable;
    wire [7:0] regA, regB, aluZ;

    assign replaceData = (muxSel) ? inputData : aluZ; // if muxSel is 1, replaceData is inputData, otherwise it is aluZ
    and clk_write(clk_writeEnable, clk, writeEnable);

    register_file regFile(clk_writeEnable, replaceData, dstSel, A_sel, B_sel, regA, regB);

    custom_alu alu(OP_Sel, regA, regB, aluZ);

endmodule