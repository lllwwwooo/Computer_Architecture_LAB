`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 16:23:41
// Design Name: 
// Module Name: register
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


module register(
    input clk,
    input [4:0] raddr1,
    output [31:0] rdata1,
    input [4:0] raddr2,
    output [31:0] rdata2,
    input we,
    input [4:0] waddr,
    input [31:0] wdata
    );
    //采用寄存器数组的形式进行描述
    reg [31:0] regts[0:31];
    
    //读操作
    assign rdata1 = regts[raddr1];
    assign rdata2 = regts[raddr2];
    
    //写操作
    always @(posedge clk) begin
        if(we) begin
            regts[waddr] <= wdata;
        end
    end
endmodule
