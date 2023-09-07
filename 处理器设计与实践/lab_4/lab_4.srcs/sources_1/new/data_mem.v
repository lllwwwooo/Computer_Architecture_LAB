`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/06 10:52:26
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input clk,
    input we,
    input [31:0] addr,
    input [31:0] w_data,
    output [31:0] data
    );
    reg [31:0] dmem [255:0];
    initial begin
        $readmemh("D:\\codes\\vivado\\lab_4\\lab4.data\\data_data.txt",dmem);
    end
    assign data=dmem[addr/4];
    always @(posedge clk)begin
        if(we) dmem[addr/4]<=w_data;
    end
endmodule
