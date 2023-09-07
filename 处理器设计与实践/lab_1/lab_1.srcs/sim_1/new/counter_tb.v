`timescale 1ns / 1ps

module counter_tb;

    // �ź�����
    reg clk;
    reg rst;
    wire [3:0] T;

    // ���ӵ������Ե� counter ģ��
    counter uut (
        .clk(clk),
        .rst(rst),
        .T(T)
    );
always #5 clk=~clk;
    // ��ʼ���ź�
    initial begin
        clk = 0;
        rst = 0;
        // ʩ�Ӹ�λ�ź�
        rst = 1;
        #10 rst = 0;

        // ģ�� 16 ��ʱ������
        repeat (16) begin
            #10;
        end

        // ��������
        $finish;
    end

endmodule
