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
    