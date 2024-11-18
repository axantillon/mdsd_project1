module top (
    input wire clk,
    input wire rst_btn,
    input wire [7:0] programSelect,
    input wire [7:0] extInputDataSW,
    output wire [6:0] R15_segDisplay,
    output wire [3:0] R15_anDisplay
);

    // Internal wires for connecting modules
    wire [15:0] instruction;
    wire [7:0] instructionAddress;
    wire [3:0] destAddress;
    wire [3:0] bAddress;
    wire [3:0] aAddress;
    wire writeSourceSelect;
    wire muxBSelect;
    wire muxASelect;
    wire [3:0] aluOpCode;
    wire writeEnable;
    wire halt;
    wire [7:0] R15_value;
    wire [7:0] selectedInputData;

    // Debounced reset signal
    wire rst_debounced;
    debouncer reset_debouncer(
        .clk(clk),
        .btn_in(rst_btn),
        .btn_out(rst_debounced)
    );

    // Clock divider for display refresh
    wire divided_clk;
    clock_divider clk_div(
        .clk_in(clk),
        .clk_out(divided_clk)
    );

    // Instruction Memory
    instructionMemory instr_mem(
        .address(instructionAddress),
        .programSelect(programSelect),
        .instruction(instruction)
    );

    // Instruction Decoder
    instructionDecoder decoder(
        .instruction(instruction),
        .clk(divided_clk),
        .rst(rst_debounced),
        .instructionAddress(instructionAddress),
        .destAddress(destAddress),
        .bAddress(bAddress),
        .aAddress(aAddress),
        .writeSourceSelect(writeSourceSelect),
        .muxBSelect(muxBSelect),
        .muxASelect(muxASelect),
        .aluOpCode(aluOpCode),
        .writeEnable(writeEnable),
        .halt(halt),
        .extInputDataSW(extInputDataSW),
        .selectedInputData(selectedInputData)
    );

    // Datapath
    datapath dp(
        .clk(divided_clk),
        .rst(rst_debounced),
        .writeEnable(writeEnable),
        .writeSourceSelect(writeSourceSelect),
        .muxBSelect(muxBSelect),
        .muxASelect(muxASelect),
        .extInputData(selectedInputData),
        .destAddress(destAddress),
        .aAddress(aAddress),
        .bAddress(bAddress),
        .aluOpCode(aluOpCode),
        .R15_out(R15_value)
    );

    // 7-segment display decoder
    bin_to_hex_7seg display_decoder(
        .in(R15_value[3:0]),  // Display lower 4 bits of R15
        .out(R15_segDisplay)
    );

    // Display control (show only on rightmost digit)
    assign R15_anDisplay = 4'b1110;  // Enable only rightmost digit

endmodule
