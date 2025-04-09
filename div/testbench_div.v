`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/07 13:10:55
// Design Name: 
// Module Name: testbench_div
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

module testbench_div;

    parameter N = 64;
    parameter M = 64;

    reg clk;
    always begin
        clk = 0; #20;
        clk = 1; #20;
    end

    reg rst;
    reg start;
    reg [N-1:0] dividend, divisor;
    wire [N-1:0] quotient;
    wire [M-1:0] remainder;
    wire done;
    wire [7:0] cnt;

    // 监控done信号的变化
    always @(done) begin
        $display("Time=%0t done=%b", $time, done);
    end

    div_module #(
        .N(N),
        .M(M)
    ) div_module_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder),
        .done(done),
        .cnt(cnt)
    );

    initial begin
        // 初始化
        start = 0;
        rst = 0;
        dividend = 0;
        divisor = 0;
        
        // 等待一些时钟周期后开始测试
        #100;

        // 测试用例1
        rst = 1;
        #100;
        rst = 0;
        dividend = 64'h8765432187654321;
        divisor = 64'h654321;
        start = 1;
        #40;  // 保持start一个时钟周期
        start = 0;
        
        wait(done);  // 等待运算完成
        #200;        // 等待一段时间

        // 测试用例2
        rst = 1;
        #100;
        rst = 0;
        dividend = 64'h1234567812345678;
        divisor = 64'h1234;
        start = 1;
        #40;
        start = 0;
        
        wait(done);
        #200;

        // 测试用例3
        rst = 1;
        #100;
        rst = 0;
        dividend = 64'hFFFFFFFFFFFFFFFF;
        divisor = 64'hF;
        start = 1;
        #40;
        start = 0;
        
        wait(done);
        #200;

        $finish;
    end

    // 添加波形监控
    initial begin
        $monitor("Time=%0t rst=%b start=%b done=%b quotient=%h remainder=%h",
                 $time, rst, start, done, quotient, remainder);
    end

endmodule