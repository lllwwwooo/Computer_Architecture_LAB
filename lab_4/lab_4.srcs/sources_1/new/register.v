`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 07:41:09
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
    //���üĴ����������ʽ��������
    reg [31:0] regts[0:31];
    
    //��ʼ��
    integer i=0;
    initial
        for(i=0;i<32;i=i+1)
            regts[i]<=0;
    
    //д����
    always @(negedge clk ) begin
        if(we) begin
            regts[waddr] <= wdata;
        end
    end
    
    //������
    assign rdata1 = regts[raddr1];
    assign rdata2 = regts[raddr2];
    
    
endmodule
