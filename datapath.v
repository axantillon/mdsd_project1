/*
    Diego Bonilla, Enrique Macaya, Sebastian Lopez, Andres Antillon
    Project 1
    ECE 2372
    Dr. Juan Carlos Rojas
    Datapath module
*/

module datapath(
    input clk, writeEnable, muxSel,
    input [0:7] inputData,
    input [0:3] dstSel,
    input [0:3] A_sel,
    input [0:3] B_sel,
    input [0:3] OP_Sel
);

    wire replaceData, clk_writeEnable;
    wire [0:7] regA, regB, aluZ;

    assign replaceData = (muxSel) ? inputData : aluZ;
    
    and clk_write(clk_writeEnable, clk, writeEnable);

    register_file regFile(clk_writeEnable, replaceData, dstSel, A_sel, B_sel, regA, regB);

    custom_alu alu(OP_Sel, regA, regB, aluZ);

endmodule