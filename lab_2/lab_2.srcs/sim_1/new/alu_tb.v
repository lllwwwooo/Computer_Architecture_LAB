`timescale 1ns / 1ps

module alu_tb;

    // �ź�����
    reg [31:0] A, B;
    reg Cin;
    reg [4:0] Card;
    wire [31:0] F;
    wire Cout;
    wire Zero;

    // ���ӵ������Ե� alu ģ��
    alu uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Card(Card),
        .F(F),
        .Cout(Cout),
        .Zero(Zero)
    );

    // ��ʼ���ź�
    initial begin
        A = 32'h12153524;
        B = 32'hc0895e18;
        Cin = 1;
        Card=5'b0;
        #10;
        repeat(15) begin
        Card=Card+1;
        #10;
        end
        // ��������
        $finish;
    end

endmodule
