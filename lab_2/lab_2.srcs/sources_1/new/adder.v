`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 16:05:12
// Design Name: 
// Module Name: adder
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


module adder(
    input [31:0] A,
    input [31:0] B,
    input  Cin,
    output reg [31:0] F,
    output Cout
    );
    integer i;
    reg C;
    always @(*)begin
        C=Cin;
        for(i=0;i<32;i=i+1) begin
            F[i]=A[i]^B[i]^C;
            C=A[i] & B[i] | (C & (A[i] ^ B[i]));  
        end
    end
    assign Cout=C; 
endmodule
