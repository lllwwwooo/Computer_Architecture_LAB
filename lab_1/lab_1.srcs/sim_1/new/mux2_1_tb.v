`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 15:51:25
// Design Name: 
// Module Name: mux2_1_tb
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


module mux2_1_tb;

    // 信号声明
    reg [1:0] d0, d1;
    reg select;
    wire [1:0] out;

    // 连接到被测试的 mux2_1 模块
    mux2_1 uut (
        .d0(d0),
        .d1(d1),
        .select(select),
        .out(out)
    );
    // 初始化信号
    initial begin
        d0 = 2'b00;
        d1 = 2'b11;
        select = 1'b0;

        repeat (10) begin
            #10; // 等待 10 个时间单位

            // 每隔一个时钟周期翻转 select 信号
            select = ~select;
        end

        // 结束仿真
        $finish;
    end

endmodule
