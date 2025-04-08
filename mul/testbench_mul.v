`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 14:12:07
// Design Name: 
// Module Name: testbench_mul
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


module testbench_mul();

    parameter A_WIDTH = 64;
    parameter B_WIDTH = 64;
    parameter P_WIDTH = A_WIDTH + B_WIDTH;

    reg clk;
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    reg rst;
    reg start;
    reg [A_WIDTH-1:0] A, B;
    wire [P_WIDTH-1:0] P;
    wire done;
    wire [7:0] cnt;

    // 监控done信号的变化
    always @(done) begin
        $display("Time=%0t done=%b", $time, done);
    end

    mul_module #(
        .A_WIDTH(A_WIDTH),
        .B_WIDTH(B_WIDTH),
        .P_WIDTH(P_WIDTH)
    ) mul_module_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .P(P),
        .done(done),
        .cnt(cnt)
    );

    initial begin
        //首次运行需要等待一段时间
        #100;
        rst = 0;
        #20;
        // Test case 1
        rst = 1;
        start = 0;
        A = 64'h0000000000000001;
        B = 64'h0000000000000002;
        #20;
        rst = 0;
        start = 1;
        #20;
        start = 0;
        #1000;

        // Test case 2
        A = 64'hFFFFFFFFFFFFFFFF;
        B = 64'hFFFFFFFFFFFFFFFF;
        //P = 0xfffffffffffffffe0000000000000001
        #20;
        rst = 1;
        start = 0;
        #20;
        rst = 0;
        start = 1;
        #20;
        start = 0;
        #1000;

        // Test case 3
        A = 64'h8765432187654321;
        B = 64'h1234567812345678;
        //P = 0x09a0cd0583fa2782eb11e7f570b88d78
        #20;
        rst = 1;
        start = 0;
        #20;
        rst = 0;
        start = 1;
        #20;
        start = 0;
        #1000;

        $finish;
    end

endmodule
