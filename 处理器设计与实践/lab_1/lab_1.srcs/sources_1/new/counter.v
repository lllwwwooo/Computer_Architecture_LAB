`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 15:44:39
// Design Name: 
// Module Name: counter
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


module counter(
    input clk,
    input [0:0] rst,
    output [3:0] T
    );
    reg [3:0] shift_register;
    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_register <= 4'b1000; // Reset the pattern
        else
            shift_register <= {shift_register[0],shift_register[3:1]};
    end

    assign T = shift_register;
endmodule