`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 16:06:20
// Design Name: 
// Module Name: adder_tb
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


module adder_tb;

    // 信号声明
    reg [31:0] A, B;
    reg Cin;
    wire [31:0] F;
    wire Cout;

    // 连接到被测试的 adder 模块
    adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .F(F),
        .Cout(Cout)
    );

    // 初始化信号
    initial begin
        Cin = 0;

        // 重复测试 10 次
        repeat (10) begin
            // 生成随机数
            A = $random;
            B = $random;
            Cin = $random&1;
            // 等待 10 个时间单位
            #10;
        end

        // 结束仿真
        $finish;
    end



endmodule
