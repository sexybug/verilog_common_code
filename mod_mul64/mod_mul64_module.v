`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 18:24:10
// Design Name: 
// Module Name: mod_mul_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: P = (A * B) mod N
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mod_mul64_module
#(
    parameter A_WIDTH = 64,
    parameter B_WIDTH = 64,
    parameter N_WIDTH = 64
)
(
    input clk,
    input rst,
    input start,
    input [A_WIDTH-1:0] A,
    input [B_WIDTH-1:0] B,
    input [N_WIDTH-1:0] N,
    output [N_WIDTH-1:0] P,
    output done
);

    reg [1:0] state;
    localparam IDLE = 2'b00;
    localparam WAIT_MUL = 2'b01;
    localparam WAIT_DIV = 2'b10;
    localparam DONE = 2'b11;

    wire [A_WIDTH+B_WIDTH-1:0] mul_result;
    wire [N_WIDTH-1:0] mod_result;
    reg mul_rst, div_rst;
    reg mul_start, div_start;
    wire mul_done, div_done;
    reg done_reg;

    mul_module #(
        .A_WIDTH(A_WIDTH),
        .B_WIDTH(B_WIDTH),
        .P_WIDTH(A_WIDTH + B_WIDTH)
    )
    mul_module_inst(
        .clk(clk),
        .rst(mul_rst),
        .start(mul_start),
        .A(A),
        .B(B),
        .P(mul_result),
        .done(mul_done),
        .cnt()
    );

    div_module #(
        .N(A_WIDTH + B_WIDTH),
        .M(N_WIDTH)
    )
    div_module_inst(
        .clk(clk),
        .rst(div_rst),
        .start(div_start),
        .dividend(mul_result),
        .divisor(N),
        .quotient(),
        .remainder(mod_result),
        .done(div_done),
        .cnt()
    );

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done_reg <= 1'b0;
            mul_rst <= 1'b1;
            div_rst <= 1'b1;
            mul_start <= 1'b0;
            div_start <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        state <= WAIT_MUL;
                        done_reg <= 1'b0;
                        mul_rst <= 1'b0;
                        div_rst <= 1'b0;
                        mul_start <= 1'b1;
                        div_start <= 1'b0;
                    end
                end
                WAIT_MUL: begin
                    if (mul_done) begin
                        state <= WAIT_DIV;
                        mul_start <= 1'b0;
                        div_start <= 1'b1;
                    end
                end
                WAIT_DIV: begin
                    if (div_done) begin
                        state <= DONE;
                        div_start <= 1'b0;
                        done_reg <= 1'b1;
                    end
                end
                DONE: begin
                    if (!start) begin
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

    assign P = mod_result;
    assign done = done_reg;

endmodule
