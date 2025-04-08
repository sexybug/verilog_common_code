`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 15:55:24
// Design Name: 
// Module Name: testbench_mod_sub
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


module testbench_mod_sub();

    parameter WIDTH = 64;
    reg [WIDTH-1:0] A, B, N;
    wire [WIDTH-1:0] R;

    // Instantiate the mod_sub module
    mod_sub_module #(
        .WIDTH(WIDTH)
    ) mod_sub_inst (
        .A(A),
        .B(B),
        .N(N),
        .R(R)
    );

    // Testbench code
    initial begin

        A = 64'h01;
        B = 64'h02;
        N = 64'h03;
        //result: 0x02
        #10;

        A = 64'h8765432187654321;
        B = 64'h1234567812345678;
        N = 64'hF234567887654321;
        //result: 0x7530eca97530eca9
        #10;

        A = 64'h1234567812345678;
        B = 64'h8765432187654321;
        N = 64'hF234567887654321;
        //result: 0x7d0369cf12345678
        #10;

        $finish;
    end

endmodule
