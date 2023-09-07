`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/06 10:52:26
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
    input [31:0] addr,
    output [31:0] data
    );
    reg [31:0] instr [255:0];
    initial begin
        $readmemh("D:\\codes\\vivado\\lab_4\\lab4.data\\inst_data.txt",instr);
    end
    assign data=instr[addr/4];
endmodule
