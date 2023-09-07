`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 19:33:34
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define ADD     5'b00001
`define ADDS    5'b00010
`define SUB     5'b00011
`define SUBS    5'b00100
`define SUB_A   5'b00101
`define SUBS_A  5'b00110
`define SAME_A  5'b00111
`define SAME_B  5'b01000
`define NOT_A   5'b01001
`define NOT_B   5'b01010
`define OR      5'b01011
`define AND     5'b01100
`define XNOR    5'b01101
`define XOR     5'b01110
`define NAND    5'b01111
`define ZERO    5'b00000
`define SLT     5'b10000
`define MOVZ    5'b10001
`define SLL     5'b10010

module alu(
    input [31:0] A,
    input [31:0] B,
    input Cin,
    input [4:0] Card,
    output [31:0] F,
    output Cout,
    output Zero
    );
    wire [32:0]    add_result;
    wire [32:0]    adds_result;
    wire [32:0]    sub_result;
    wire [32:0]    subs_result;
    wire [32:0]    sub_a_result;
    wire [32:0]    subs_a_result;
    wire [32:0]    same_a_result;
    wire [32:0]    same_b_result;
    wire [32:0]    not_a_result;
    wire [32:0]    not_b_result;
    wire [32:0]    or_result;
    wire [32:0]    and_result;
    wire [32:0]    xnor_result;
    wire [32:0]    xor_result;
    wire [32:0]    nand_result;
    wire [32:0]    zero_result;
    wire [32:0]    slt_result;
    wire [32:0]    movz_result;
    wire [32:0]    sll_result;
    
    assign    add_result=A+B;
    assign    adds_result=A+B+Cin;
    assign    sub_result=A-B;
    assign    subs_result=A-B-Cin;
    assign    sub_a_result=B-A;
    assign    subs_a_result=B-A-Cin;
    assign    same_a_result=A;
    assign    same_b_result=B;
    assign    not_a_result=~A;
    assign    not_b_result=~B;
    assign    or_result=A|B;
    assign    and_result=A&B;
    assign    xnor_result=~(A^B);
    assign    xor_result=A^B;
    assign    nand_result=~(A&B);
    assign    zero_result=0;
    assign    slt_result=(A<B)?32'h1:32'h0;
    assign    movz_result=(B == 32'h0)?A:B;
    assign    sll_result=B << A[4:0]; // 左移B的位数由A的低5位指定;
    
    assign  F   =   ({32{Card == `ADD}}  & add_result)  |
                    ({32{Card == `SUB}}  & sub_result)  |
                    ({32{Card == `ADDS}}  & adds_result)  |
                    ({32{Card == `SUBS}} & subs_result) |
                    ({32{Card == `SUB_A}}  & sub_a_result)  |
                    ({32{Card == `SUBS_A}}  & subs_a_result)  |
                    ({32{Card == `SAME_A}}  & same_a_result)  |
                    ({32{Card == `SAME_B}}  & same_b_result)  |
                    ({32{Card == `NOT_A}}  & not_a_result)  |
                    ({32{Card == `NOT_B}}  & not_b_result)  |
                    ({32{Card == `OR}}  & or_result)  |
                    ({32{Card == `AND}}  & and_result)  |
                    ({32{Card == `XNOR}}  & xnor_result)  |
                    ({32{Card == `XOR}}  & xor_result)  |
                    ({32{Card == `NAND}}  & nand_result)  |
                    ({32{Card == `ZERO}}  & zero_result)|
                    ({32{Card == `SLT}}  & slt_result)  |
                    ({32{Card == `MOVZ}}  & movz_result)  |
                    ({32{Card == `SLL}}  & sll_result);
       
    assign  Cout =  (Card == `ADD) ? add_result[32] :
                    (Card == `ADDS) ? adds_result[32] :
                    (Card == `SUB) ? sub_result[32] :
                    (Card == `SUBS) ? subs_result[32] :
                    (Card == `SUB_A) ? sub_a_result[32] :
                    (Card == `SUBS_A) ? subs_a_result[32] :
                    1'b0;
    assign  Zero =  (F == 32'h0);
endmodule
