`timescale 1ns / 1ps

module counter_tb;

    // 信号声明
    reg clk;
    reg rst;
    wire [3:0] T;

    // 连接到被测试的 counter 模块
    counter uut (
        .clk(clk),
        .rst(rst),
        .T(T)
    );
always #5 clk=~clk;
    // 初始化信号
    initial begin
        clk = 0;
        rst = 0;
        // 施加复位信号
        rst = 1;
        #10 rst = 0;

        // 模拟 16 个时钟周期
        repeat (16) begin
            #10;
        end

        // 结束仿真
        $finish;
    end

endmodule
