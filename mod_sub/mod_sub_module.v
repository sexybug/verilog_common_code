`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 15:54:47
// Design Name: 
// Module Name: mod_sub
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: R = (A - B) mod N, 0 <= A,B < N
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mod_sub_module
#(
    parameter WIDTH = 64
)
(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [WIDTH-1:0] N,
    output [WIDTH-1:0] R
);

    wire [WIDTH:0] diff;
    assign diff = A - B;
    assign R = (diff[WIDTH]) ? (diff + {1'b0,N}) : diff[WIDTH-1:0];

endmodule
