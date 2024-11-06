`timescale 1ns/1ns;

module custom_alu_tb;
    reg[3:0] OP;
    reg[7:0] A;
    reg[7:0] B;
    wire[7:0] Z;
    
    custom_alu uut (
        .OP(OP),
        .A(A),
        .B(B),
        .Z(Z),
    );
    
initial begin
    
    $monitor("OP: %b | A: %b | B: %b | Z: %b", OP, A, B, Z);

    OP = 4'b0000; A = 8'b0; B = 8'b0;
    #10;

    