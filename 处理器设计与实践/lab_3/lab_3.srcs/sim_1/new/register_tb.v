`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 16:25:41
// Design Name: 
// Module Name: register_tb
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


module register_tb;

    // 信号声明
    reg clk;
    reg [4:0] raddr1, raddr2, waddr;
    wire [31:0] rdata1, rdata2;
    reg we;
    reg [31:0] wdata;

    // 连接到被测试的 register 模块
    register uut (
        .clk(clk),
        .raddr1(raddr1),
        .rdata1(rdata1),
        .raddr2(raddr2),
        .rdata2(rdata2),
        .we(we),
        .waddr(waddr),
        .wdata(wdata)
    );
always #5 clk = ~clk;
    // 初始化信号
    initial begin
        // 初始化时钟
        clk = 0;
        // 初始化数据
        we = 0;
        raddr1 = 5'b00000;
        raddr2 = 5'b00000;
        waddr = 5'b00100;
        wdata = 32'h12345678;

        // 写入数据到寄存器 B00100
        we = 1;
        #10; // 等待一个时钟周期

        // 写入数据到寄存器 B00010
        waddr = 5'b00010;
        wdata = 32'hFFFFFEDA;
        we = 1;
        #10; // 等待一个时钟周期
        we = 0;
        raddr1 = 5'b00010;
        raddr2 = 5'b00100;
        // 读取数据
        #10; // 等待一个时钟周期
        
        $finish;
    end

endmodule
