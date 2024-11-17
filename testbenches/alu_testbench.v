module alu_testbench;

    reg [3:0] OP;
    reg [7:0] A;
    reg [7:0] B;
    wire [7:0] Z;

    alu uut (
        .OP(OP),
        .A(A),
        .B(B),
        .Z(Z)
    );

    initial begin
        // Test each operation with some combinations of A and B

        $display("\nZero");
        OP = 4'b0000; #10;

        $display("\nOne");
        OP = 4'b0001; #10;

        A = 8'b10101010;
        B = 8'b00001111;

        $display("\nA");
        OP = 4'b0010; #10;

        $display("\nB");
        OP = 4'b0011; #10;

        $display("\nAdd");
        OP = 4'b0100; #10;

        $display("\nNegate A to Twos complement");
        OP = 4'b0101; #10;

        A = 8'b01010101;
        B = 8'b11110000;

        $display("\nBitwise AND");
        OP = 4'b0110; #10;

        $display("\nBitwise OR");
        OP = 4'b0111; #10;

        A = 8'b00001111;
        B = 8'b00001111;

        $display("\nA == B");
        OP = 4'b1000; #10;

        A = 8'b00001111;
        B = 8'b00000000;

        #10;

        $display("\nA > B");
        OP = 4'b1001; #10;

        A = 8'b00000000;
        B = 8'b00001111;

        #10;

        $finish;
    end

    initial begin
        // $monitor("t=%3d OP=%b A=%b B=%b Z=%b", $time, OP, A, B, Z);
        // $dumpfile("alu_testbench.vcd");
    end

endmodule
