`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 10:05:05
// Design Name: 
// Module Name: mod_add_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: S = (A + B) mod N, 0 <= A,B < N
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mod_add_module
#(parameter WIDTH = 64)
(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [WIDTH-1:0] N,
    output [WIDTH-1:0] S
);

    wire [WIDTH:0] sum;
    assign sum = A + B;
    assign S = (sum >= {1'b0,N}) ? (sum - {1'b0,N}) : sum;

endmodule
