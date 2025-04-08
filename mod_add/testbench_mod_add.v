`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 10:56:17
// Design Name: 
// Module Name: testbench_mod_add
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


module testbench_mod_add();

    parameter WIDTH = 64;

    reg [WIDTH-1:0] A, B, N;
    wire [WIDTH-1:0] S;
    mod_add_module #(
        .WIDTH(WIDTH)
    ) mod_add_module_inst (
        .A(A),
        .B(B),
        .N(N),
        .S(S)
    );

    initial begin
        // Test case 1
        A = 64'h0000000000000001;
        B = 64'h0000000000000002;
        N = 64'h0000000000000003;
        #4;
        //result: 000000000000000000
        $display("A: %h, B: %h, N: %h, S: %h", A, B, N, S);

        // Test case 2
        A = 64'hFFFFFFFFFFFFFFFE;
        B = 64'hFFFFFFFFFFFFFFFE;
        N = 64'hFFFFFFFFFFFFFFFF;
        #4;
        //result: 0xfffffffffffffffd
        $display("A: %h, B: %h, N: %h, S: %h", A, B, N, S);

        // Test case 3
        A = 64'h7FFFFFFFFFFFFFFE;
        B = 64'h8000000000000000;
        N = 64'hFFFFFFFFFFFFFFFF;
        #10;
        //result: 0xfffffffffffffffe
        $display("A: %h, B: %h, N: %h, S: %h", A, B, N, S);

        // Test case 4
        A = 64'h023456789ABCDEF0;
        B = 64'h0FEDCBA987654321;
        N = 64'h1111111111111111;
        #10;
        //result: 0x111111111111100
        $display("A: %h, B: %h, N: %h, S: %h", A, B, N, S);

        // 结束仿真
        $finish;
    end

endmodule
