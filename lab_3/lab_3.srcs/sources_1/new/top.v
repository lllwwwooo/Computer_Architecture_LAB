`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 16:23:41
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input ram_wen,
    input r_wen,
    input [4:0] Card,
    input [4:0] r_addr1,
    input [4:0] r_addr2,
    input [15:0] ram_addr,
    input [31:0] ram_wdata,
    output  [31:0] ram_rdata,
    output [31:0] r_data1,
    output [31:0] r_data2,
    input [4:0] r_waddr,
    input [31:0] r_wdata,
    output [31:0] F
    );
    block_ram block_ram(
    .clka (clk       ),
    .wea  (ram_wen   ),
    .addra(ram_addr  ),
    .dina (ram_wdata ),
    .douta(ram_rdata ) 
    );
    
    register register(
        .clk(clk),
        .raddr1(r_addr1),
        .rdata1(r_data1),
        .raddr2(r_addr2),
        .rdata2(r_data2),
        .we(r_wen),
        .waddr(r_waddr),
        .wdata(r_wdata)
    );
    
    alu alu(
    .A(r_data1),
    .B(r_data2),
    .Cin(Cin),
    .Card(Card),
    .F(F),
    .Cout(Cout),
    .Zero(Zero)
    );
    
    assign Cin=0;
    //assign Card=5'b00001;
endmodule
