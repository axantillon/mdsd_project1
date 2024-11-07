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

    wire clk_writeEnable;
    wire [7:0] regA, regB, aluZ;
    wire [7:0] replaceData;

    assign replaceData = (muxSel) ? inputData : aluZ; // if muxSel is 1, replaceData is inputData, otherwise it is aluZ
    and clk_write(clk_writeEnable, clk, writeEnable);

    register_file regFile(clk_writeEnable, replaceData, dstSel, A_sel, B_sel, regA, regB);
    alu alu(OP_Sel, regA, regB, aluZ);

endmodule

module datapath_testbench();

    // Inputs
    reg clk, writeEnable, muxSel;
    reg [7:0] inputData;
    reg [3:0] dstSel, A_sel, B_sel, OP_Sel;

    // Instantiate the datapath module
    datapath uut(clk, writeEnable, muxSel, inputData, dstSel, A_sel, B_sel, OP_Sel);

    // Clock Generation
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        // Load values into registers 0-5
        writeEnable = 1;
        muxSel = 1;

        inputData = 8'd2;
        dstSel = 4'b0000;
        #10;
        $display("Register 0 (should be 2): %d", uut.regFile.regs[0]);

        inputData = 8'd4;
        dstSel = 4'b0001;
        #10;
        $display("Register 1 (should be 4): %d", uut.regFile.regs[1]);

        inputData = 8'd8;
        dstSel = 4'b0010;
        #10;
        $display("Register 2 (should be 8): %d", uut.regFile.regs[2]);

        inputData = 8'd16;
        dstSel = 4'b0011;
        #10;
        $display("Register 3 (should be 16): %d", uut.regFile.regs[3]);

        // Load 10101010 into register 4 and 11001100 into register 5
        $display("\nLoading 10101010 into register 4 and 11001100 into register 5");

        inputData = 8'b10101010;
        dstSel = 4'b0100;
        #10;
        $display("Register 4 (should be 10101010): %b", uut.regFile.regs[4]);

        inputData = 8'b11001100;
        dstSel = 4'b0101;
        #10;
        $display("Register 5 (should be 11001100): %b", uut.regFile.regs[5]);

        // Switch to ALU operations
        muxSel = 0;
        #10;

        $display("\nAdding 2 and 4 from registers 0 and 1");
        OP_Sel = 4'b0100;  // ADD operation
        A_sel = 4'b0000;
        B_sel = 4'b0001;
        dstSel = 4'b1111;
        #20;
        $display("ALU output register 15 (should be 6): %d", uut.regFile.regs[15]);

        // Test greater than between 2 and 4
        $display("\nTesting greater than between 2 and 4 from registers 0 and 1");
        OP_Sel = 4'b1001;  // Greater Than operation
        A_sel = 4'b0000;
        B_sel = 4'b0001;
        dstSel = 4'b1110;
        #20;
        $display("ALU output register 14 (should be 0): %d", uut.regFile.regs[14]);

        // Test greater than between 8 and 4
        $display("\nTesting greater than between 8 and 4 from registers 2 and 1");
        OP_Sel = 4'b1001;
        A_sel = 4'b0010;
        B_sel = 4'b0001;
        dstSel = 4'b1101;
        #20;
        $display("ALU output register 13 (should be 1): %d", uut.regFile.regs[13]);

        // Test equals between 8 and 8
        $display("\nTesting equals between 8 and 8");
        OP_Sel = 4'b1000;
        A_sel = 4'b0010;
        B_sel = 4'b0010;
        dstSel = 4'b1100;
        #20;
        $display("ALU output register 12 (should be 1): %d", uut.regFile.regs[12]);

        // Test subtraction using two's complement
        $display("\nTesting subtracting 8 from 16 using two's complement");
        OP_Sel = 4'b0101;  // Two's complement
        A_sel = 4'b0010;   // Register 2 contains 8
        dstSel = 4'b1011;  // Store negated value in register 11
        #10;
        $display("Register 11 (should be -8): %d", $signed(uut.regFile.regs[11]));

        OP_Sel = 4'b0100;  // ADD operation
        A_sel = 4'b0011;   // Register 3 contains 16
        B_sel = 4'b1011;   // Register 11 contains -8
        dstSel = 4'b1010;  // Store result in register 10
        #20;
        $display("Register 10 (should be 8): %d", uut.regFile.regs[10]);

        // Test greater than between 4 and 8 and save to register 9
        $display("\nTesting greater than between 4 and 8");
        OP_Sel = 4'b1001;  // Greater Than operation
        A_sel = 4'b0001;  // Register 1 contains 4
        B_sel = 4'b0010;  // Register 2 contains 8
        dstSel = 4'b1001;
        #20;
        $display("ALU output register 9 (should be 0): %d", uut.regFile.regs[9]);

        // Test bitwise AND between 10101010 and 11001100 and save to register 8
        $display("\nTesting bitwise AND between 10101010 and 11001100");
        OP_Sel = 4'b0110;
        A_sel = 4'b0100;
        B_sel = 4'b0101;
        dstSel = 4'b1000;
        #40;  // Increased delay for stability
        $display("ALU output register 8 (should be 00001000): %b", uut.regFile.regs[8]);

        // Test bitwise OR between 10101010 and 11001100 and save to register 7
        $display("\nTesting bitwise OR between 10101010 and 11001100");
        OP_Sel = 4'b0111;
        A_sel = 4'b0100;
        B_sel = 4'b0101;
        dstSel = 4'b0111;
        #40;  // Increased delay for stability
        $display("ALU output register 7 (should be 11101110): %b", uut.regFile.regs[7]);

        // Test zero operation and save to register 6
        $display("\nTesting zero operation");
        OP_Sel = 4'b0000;
        dstSel = 4'b0110;
        #20;
        $display("ALU output register 6 (should be 0): %d", uut.regFile.regs[6]);

        $finish;
    end

    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, datapath_testbench);
    end

endmodule
