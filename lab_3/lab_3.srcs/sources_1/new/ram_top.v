`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 16:42:38
// Design Name: 
// Module Name: ram_top
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


module ram_top (
    input         clk      ,
    input  [15:0] ram_addr ,
    input  [31:0] ram_wdata,
    input         ram_wen  ,
    output [31:0] ram_rdata
);
					   
block_ram block_ram (
    .clka (clk       ),
    .wea  (ram_wen   ),
    .addra(ram_addr  ),
    .dina (ram_wdata ),
    .douta(ram_rdata ) 
);
endmodule