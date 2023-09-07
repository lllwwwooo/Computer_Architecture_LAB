`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/01 13:55:12
// Design Name: 
// Module Name: cpu
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
`define Add     6'b100000
`define Sub     6'b100010
`define And     6'b100100
`define Or      6'b100101
`define Xor     6'b100110
`define Slt     6'b101010
`define Movz    6'b001010
`define Sll     5'b000000

`define OP      6'b000000
`define SW      6'b101011
`define LW      6'b100011
`define BNE     6'b000101
`define J       6'b000010

`define IF      3'b000
`define ID      3'b001
`define EX      3'b010
`define MEM     3'b011
`define WB      3'b100


module cpu (
    input clk,
    input resetn,
    output [31:0] debug_wb_pc,
    output debug_wb_rf_wen,
    output [4:0] debug_wb_rf_addr,
    output [31:0] debug_wb_rf_wdata
);
  (* MARK_DEBUG="true" *)reg ram_wen, we, opcode_valid;
  (* MARK_DEBUG="true" *)reg [2:0] state,next_state;
  (* MARK_DEBUG="true" *)reg [4:0] Card, raddr1, raddr2, r_waddr;
  //(* MARK_DEBUG="true" *)reg [15:0] ram_addr;
  (* MARK_DEBUG="true" *)reg [31:0] r_wdata,ram_addr, ram_wdata,  A,B,Imm, PC,NPC;
  (* MARK_DEBUG="true" *)wire [31:0] rdata1,rdata2,F,ram_rdata,IR;
  (* MARK_DEBUG="true" *)wire Zero;

  //通用寄存器组
  register register (
      .clk(clk),
      .raddr1(raddr1),
      .rdata1(rdata1),
      .raddr2(raddr2),
      .rdata2(rdata2),
      .we(we),
      .waddr(r_waddr),
      .wdata(r_wdata)
  );

  //ALU
  alu alu (
      .A(A),
      .B(B),
      .Cin(1'b0),
      .Card(Card),
      .F(F),
      .Cout(Cout),
      .Zero(Zero)
  );

//  // 指令存储器
//  block_mem instr_mem (
//      .clka (clk),
//      .wea  (1'b0),   // 指令存储器只读
//      .addra(PC[15:0]/4),
//      .dina (32'h0),  // 写入0，因为这是只读存储器
//      .douta(IR)
//  );
//  // 数据存储器
//  block_mem1 data_mem (
//      .clka (clk),
//      .wea  (ram_wen),
//      .addra(ram_addr),
//      .dina (ram_wdata),
//      .douta(ram_rdata)
//  );
    instr_mem instr_mem(
        .addr(PC),
        .data(IR)
    );
    data_mem data_mem(
      .clk (clk),
      .we  (ram_wen),
      .addr(ram_addr),
      .w_data (ram_wdata),
      .data(ram_rdata)
    );
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            PC<=32'h0;
            state <= `IF; // 初始状态为取指阶段
        end else begin
            state <= next_state; // 使用下一个状态
            //if(state==`WB)PC<=NPC;
        end
    end
  always @(*) begin
        case (state)
            `IF:begin
                //if (opcode_valid) begin
                NPC=PC+4;
                case(IR[31:26])
                    `OP:begin
                        raddr1=IR[25:21];
                        raddr2=IR[20:16];
                        r_waddr=IR[15:11];
                        if(IR[5:0]==`Sll)Imm=IR[10:6];
                    end
                    `SW,`BNE:begin
                        raddr1=IR[25:21];
                        raddr2=IR[20:16];
                        Imm=IR[15:0];
                    end
                    `LW:begin
                        raddr1=IR[25:21];
                        raddr2=5'b0;
                        r_waddr=IR[20:16];
                        Imm=IR[15:0];
                    end
                    `J:begin
                        Imm=IR[25:0];
                    end
                endcase
                next_state = `ID; // 解码
            end
            `ID:begin
                //type
                case(IR[31:26])
                    `OP:begin
                        A=rdata1;
                        B=rdata2;
                        case(IR[5:0])
                        `Add:begin
                            Card=`ADD;
                        end
                        `Sub:begin
                            Card=`SUB;
                        end
                        `And:begin
                            Card=`AND;
                        end
                        `Or:begin
                            Card=`OR;
                        end
                        `Xor:begin
                            Card=`XOR;
                        end
                        `Slt:begin
                            Card=`SLT;
                        end
                        `Movz:begin
                            Card=`MOVZ;
                        end
                        `Sll:begin
                            A=Imm;
                            Card=`SLL;
                        end
                        endcase
                    end
                    `SW,`LW:begin
                        A=rdata1;
                        B=Imm;
                        Card=`ADD;
                    end
                    `BNE:begin
                        A=rdata1;
                        B=rdata2;
                        Card=`SUB;
                    end
                endcase
                next_state = `EX;
            end
            `EX:begin
                //type
                case(IR[31:26])
                    `SW:begin
                        ram_addr=F;
                        ram_wdata=rdata2;
                        ram_wen=1'b1;
                    end
                    `LW:begin
                        ram_addr=F;
                    end
                    `BNE:begin
                        if(!Zero)NPC=NPC+(Imm<<2);
                    end
                    `J:begin
                        NPC={NPC[31:26],Imm<<2};
                    end
                endcase
                next_state = `MEM;
            end
            `MEM:begin
                case(IR[31:26])
                    `OP:begin
                        r_wdata=F;
                        we=1'b1;
                    end
                    `LW:begin
                        r_wdata=ram_rdata;
                        we=1'b1;
                    end
                endcase
                ram_wen=1'b0;
                next_state = `WB;
            end
            `WB:begin
                //type
                PC=NPC;
                we=1'b0;
                next_state = `IF;
            end
        endcase
    end
  
  // 调试信息
  assign debug_wb_pc = PC;//32'bX;
  assign debug_wb_rf_wen = we;
  assign debug_wb_rf_addr = r_waddr;//32'bX;
  assign debug_wb_rf_wdata =r_wdata;// 32'bX;


endmodule
