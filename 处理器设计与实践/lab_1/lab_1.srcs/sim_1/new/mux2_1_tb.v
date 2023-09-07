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

    // �ź�����
    reg [1:0] d0, d1;
    reg select;
    wire [1:0] out;

    // ���ӵ������Ե� mux2_1 ģ��
    mux2_1 uut (
        .d0(d0),
        .d1(d1),
        .select(select),
        .out(out)
    );
    // ��ʼ���ź�
    initial begin
        d0 = 2'b00;
        d1 = 2'b11;
        select = 1'b0;

        repeat (10) begin
            #10; // �ȴ� 10 ��ʱ�䵥λ

            // ÿ��һ��ʱ�����ڷ�ת select �ź�
            select = ~select;
        end

        // ��������
        $finish;
    end

endmodule
