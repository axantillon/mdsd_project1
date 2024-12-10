module top (
    input wire clk,
    input wire rst_btn,
    input wire [7:0] programSelect,
    input wire [7:0] extInputDataSW,
    output wire [6:0] R15_segDisplay,
    output reg [3:0] R15_anDisplay
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
        .selectedInputData(selectedInputData),
        .haltCondition(haltCondition)
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
        .R15_out(R15_value),
        .halt(halt),
        .haltCondition(haltCondition)
    );

    // Display control
    reg [3:0] display_value;
    reg [16:0] display_counter;
    
    // Initialize R15_anDisplay to 4'b1110 (rightmost display active)
    initial begin
        R15_anDisplay = 4'b1110;
    end
    
    always @(posedge clk) begin
        if (rst_debounced) begin
            display_counter <= 0;
            display_value <= 0;
        end else begin
            display_counter <= display_counter + 1;

            if (display_counter[16]) begin
                R15_anDisplay <= {R15_anDisplay[2:0], R15_anDisplay[3]};
                display_counter <= 0;
            end

            case (R15_anDisplay)
                4'b1110: display_value <= R15_value[3:0];      // Rightmost display: lower 4 bits of R15
                4'b1101: display_value <= R15_value[7:4];      // Second from right: upper 4 bits of R15
                4'b1011: display_value <= extInputDataSW[3:0]; // Third from right: lower 4 bits of switch input
                4'b0111: display_value <= extInputDataSW[7:4]; // Leftmost display: upper 4 bits of switch input
                default: display_value <= 4'b0000;             // Default case: display 0
            endcase
        end
    end

    // 7-segment display decoder
    bin_to_hex_7seg display_decoder(
        .in(display_value),
        .out(R15_segDisplay)
    );

endmodule
