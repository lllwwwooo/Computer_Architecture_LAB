`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 16:35:33
// Design Name: 
// Module Name: top_tb
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


module top_tb;
// �ź�����
    reg clk;
    reg ram_wen, r_wen;
    reg [4:0] Card;
    reg [4:0] r_addr1, r_addr2, r_waddr;
    reg [15:0] ram_addr;
    reg [31:0] ram_wdata, r_wdata;
    wire [31:0] ram_rdata, r_data1, r_data2, F;

    // ���ӵ������Ե� top ģ��
    top uut (
        .clk(clk),
        .ram_wen(ram_wen),
        .r_wen(r_wen),
        .Card(Card),
        .r_addr1(r_addr1),
        .r_addr2(r_addr2),
        .ram_addr(ram_addr),
        .ram_wdata(ram_wdata),
        .ram_rdata(ram_rdata),
        .r_data1(r_data1),
        .r_data2(r_data2),
        .r_waddr(r_waddr),
        .r_wdata(r_wdata),
        .F(F)
    );
    always #5 clk = ~clk;
    // ��ʼ���ź�
    initial begin
        // ��ʼ��ʱ��
        clk = 0;
        // ���мӷ�����
        Card = 5'b00001;
        // ��ʼ������
        ram_wen = 0;
        r_wen = 0;
        r_addr1 = 5'b00001;
        r_addr2 = 5'b00010;
        r_waddr = 0;
        r_wdata = 32'h0;
        
        // д�����ݵ� RAM
        ram_wen = 1;
        ram_addr = 0;
        ram_wdata = 32'h12345678;
        #10; // �ȴ�һ��ʱ������
        r_wen=1;
        r_waddr = 5'b00001;
        r_wdata=ram_rdata;
        #5;
        ram_wen = 0;
        #15;
        
        // д�����ݵ� RAM
        ram_wen = 1;
        ram_addr = 16'h1;;
        ram_wdata = 32'hABCDEF01;
        #10; // �ȴ�һ��ʱ������
        // ��ȡ RAM ���ݵ��Ĵ���
        r_wen=1;
        r_waddr = 5'b00010;
        r_wdata=ram_rdata;
        #5;
        ram_wen = 0;
        #15;
        
        
        
        // ��������� RAM
        ram_wen = 1;
        ram_addr=16'h2;
        ram_wdata=F;
        #10; // �ȴ�һ��ʱ������
        // ���������Ĵ���
        r_wen = 1;
        r_waddr=5'b00011;
        r_wdata=F;
        #5
        ram_wen = 0;
        r_wen = 0;
        r_addr1=5'b00011;
    end
endmodule
