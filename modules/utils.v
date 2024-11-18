module debouncer(
    input clk,
    input btn_in,
    output reg btn_out
);
    reg [19:0] count = 0;
    reg btn_prev = 0;
    reg stable_btn = 0;

    // Help from Claude 3.5 Sonnet for version without need for clock divider
    // Emits a single pulse when button is pressed, regardless of how long it is pressed
    
    always @(posedge clk) begin
        // If button state changed, reset counter
        if (btn_in != btn_prev) begin
            count <= 0;
            btn_prev <= btn_in;
            btn_out <= 0;  // Reset output during unstable period
        // If we've counted long enough and button is stable
        end else if (count == 20'hFFFFF) begin
            if (btn_prev && !stable_btn) begin  // Only pulse on initial press
                btn_out <= 1;
                stable_btn <= 1;
            end else begin
                btn_out <= 0;
            end
        end else begin
            count <= count + 1;
            btn_out <= 0;
        end
        
        // Reset stable_btn when button is released
        if (!btn_prev) begin
            stable_btn <= 0;
        end
    end
endmodule

module bin_to_hex_7seg(
    input [3:0] in,
    output reg [6:0] out  
);
    
    always @(in) begin
        case (in)
            4'b0000 : out <= 7'b1000000;    // digit 0
            4'b0001 : out <= 7'b1111001;    // digit 1
            4'b0010 : out <= 7'b0100100;    // digit 2
            4'b0011 : out <= 7'b0110000;    // digit 3
            4'b0100 : out <= 7'b0011001;    // digit 4
            4'b0101 : out <= 7'b0010010;    // digit 5
            4'b0110 : out <= 7'b0000010;    // digit 6
            4'b0111 : out <= 7'b1111000;    // digit 7
            4'b1000 : out <= 7'b0000000;    // digit 8
            4'b1001 : out <= 7'b0010000;    // digit 9
            4'b1010 : out <= 7'b0001000;    // digit A
            4'b1011 : out <= 7'b0000011;    // digit B
            4'b1100 : out <= 7'b1000110;    // digit C
            4'b1101 : out <= 7'b0100001;    // digit D
            4'b1110 : out <= 7'b0000110;    // digit E
            4'b1111 : out <= 7'b0001110;    // digit F
        endcase
    end
endmodule

module clock_divider(
    input clk_in,
    output reg clk_out
);
    // For 1Hz output (100MHz / 2^27 ≈ 0.75Hz)
    reg [26:0] counter = 0;
    
    always @(posedge clk_in) begin
        counter <= counter + 1;
        clk_out <= counter[26];  // Use MSB as divided clock
        // Different speed options (uncomment the desired speed):
        //clk_out <= counter[25];  // ~1.5 Hz
        //clk_out <= counter[24];  // ~3 Hz
        //clk_out <= counter[23];  // ~6 Hz
        //clk_out <= counter[22];  // ~12 Hz
    end
endmodule