`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 18:43:07
// Design Name: 
// Module Name: testbench_mod_mul
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


module testbench_mod_mul();

    parameter A_WIDTH = 64;
    parameter B_WIDTH = 64;
    parameter N_WIDTH = 64;

    reg clk;
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    reg rst;
    reg start;
    reg [A_WIDTH-1:0] A;
    reg [B_WIDTH-1:0] B;
    reg [N_WIDTH-1:0] N;
    wire [N_WIDTH-1:0] P;
    wire done;

    mod_mul64_module #(
        .A_WIDTH(A_WIDTH),
        .B_WIDTH(B_WIDTH),
        .N_WIDTH(N_WIDTH)
    ) mod_mul_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .N(N),
        .P(P),
        .done(done)
    );

    initial begin
        //暂停，等待添加信号
        $stop;
        //首次运行需要等待一段时间
        #100;
        rst = 0;
        #20;

        rst = 1;
        #20;
        rst = 0;
        start = 0;
        #20;
        A = 64'h0000000000000001;
        B = 64'h0000000000000002;
        N = 64'hFFFFFFFFFFFFFFFF;
        start = 1;
        #10;
        start = 0;
        #2500;
        $display("mul_result = %h", P);

        rst = 1;
        #20;
        rst = 0;
        A = 64'h1234567812345678;
        B = 64'h1234567812345678;
        N = 64'hFFFFFFFFFFFFFFFF;
        //result: 0x3e807e383e807e38
        start = 1;
        #10;
        start = 0;
        #2500;
        $display("mul_result = %h", P);

        rst = 1;
        #20;
        rst = 0;
        A = 64'h8765432187654321;
        B = 64'h1234567812345678;
        N = 64'hFFFFFFFFFFFFFFFF;
        //result: 0xf4b2b4faf4b2b4fa
        start = 1;
        #10;
        start = 0;
        #2500;
        $display("mul_result = %h", P);

        rst = 1;
        #20;
        rst = 0;
        A = 64'h8765432187654321;
        B = 64'h1234567812345678;
        N = 64'h34567812345678;
        //result: 0x21cd8ba5c11338
        start = 1;
        #10;
        start = 0;
        #2500;
        $display("mul_result = %h", P);

        rst = 1;
        #20;
        rst = 0;
        A = 64'hFFFFFFFFFFFFFFFF;
        B = 64'hFFFFFFFFFFFFFFFF;
        N = 64'h12345678;
        //result: 0x147c1e9
        start = 1;
        #10;
        start = 0;
        #2500;
        $display("mul_result = %h", P);

        $finish;
    end

endmodule
