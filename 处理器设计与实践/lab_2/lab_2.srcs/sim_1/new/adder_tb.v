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

    // �ź�����
    reg [31:0] A, B;
    reg Cin;
    wire [31:0] F;
    wire Cout;

    // ���ӵ������Ե� adder ģ��
    adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .F(F),
        .Cout(Cout)
    );

    // ��ʼ���ź�
    initial begin
        Cin = 0;

        // �ظ����� 10 ��
        repeat (10) begin
            // ���������
            A = $random;
            B = $random;
            Cin = $random&1;
            // �ȴ� 10 ��ʱ�䵥λ
            #10;
        end

        // ��������
        $finish;
    end



endmodule
