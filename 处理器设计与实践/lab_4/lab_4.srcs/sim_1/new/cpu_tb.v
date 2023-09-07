`timescale 1ns / 1ps
`timescale 1ns / 1ps

//module cpu_tb(

//    );

////-----Clock and reset signal simulation-----
////signals
//    reg clk;
//    reg resetn;
//    wire [31:0] debug_wb_pc;
//    wire        debug_wb_rf_wen;
//    wire [4 :0] debug_wb_rf_addr;
//    wire [31:0] debug_wb_rf_wdata;

//    cpu U_cpu(
//        .clk               (clk               ),
//        .resetn            (resetn             ),
//        .debug_wb_pc       (debug_wb_pc       ),
//        .debug_wb_rf_wen   (debug_wb_rf_wen   ),
//        .debug_wb_rf_addr  (debug_wb_rf_addr  ),
//        .debug_wb_rf_wdata (debug_wb_rf_wdata )
//    );
////simulation
//initial begin
//    clk    = 1'b0;
//    resetn = 1'b0;
//    #20;
//    resetn = 1'b1;
//end

//always #5 clk = ~clk;

//cpu_top U_cpu_top(
//        .clk     (clk     ),
//        .reset   (resetn  )
//    );

////-----monitor test-----
//initial
//begin
//    $timeformat(-9,0," ns",10);
//    while(!resetn) #5;
//    $display("==============================================================");
//    $display("Test begin!");
//    #10000;
//end

//endmodule
module cpu_tb();
    reg clk;
    reg resetn;
    wire [31:0] debug_wb_pc;
    wire        debug_wb_rf_wen;
    wire [4 :0] debug_wb_rf_addr;
    wire [31:0] debug_wb_rf_wdata;

    cpu U_cpu(
        .clk               (clk               ),
        .resetn            (resetn             ),
        .debug_wb_pc       (debug_wb_pc       ),
        .debug_wb_rf_wen   (debug_wb_rf_wen   ),
        .debug_wb_rf_addr  (debug_wb_rf_addr  ),
        .debug_wb_rf_wdata (debug_wb_rf_wdata )
    );
    cpu_top U_cpu_top(
        .clk     (clk     ),
        .reset   (resetn  )
    );
//simulation
always #5 clk = ~clk;
initial begin
    clk    = 1'b0;
    resetn = 1'b0;
    #50;
    resetn = 1'b1;
    #10000;
end
endmodule
