`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/07 10:24:26
// Design Name: 
// Module Name: div_module
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


module div_module
#(  parameter N = 64,
    parameter M = 64
)
(
    input clk,
    input rst,
    input start,
    input [N-1:0] dividend,
    input [M-1:0] divisor,
    output [N-1:0] quotient,
    output [M-1:0] remainder,
    output done,
    output [7:0] cnt
);

    reg [1:0] state;
    localparam IDLE = 2'b00;
    localparam CALC = 2'b01;
    localparam DONE = 2'b10;

    reg [N-1:0] dividend_reg;
    reg [M-1:0] divisor_reg;
    reg [N-1:0] quotient_reg;
    reg [M-1:0] remainder_reg;
    reg [7:0] count;
    reg done_reg;

    always@(posedge clk, posedge rst) begin
        if(rst) begin
            state <= IDLE;
            dividend_reg <= 'b0;
            divisor_reg <= 'b0;
            quotient_reg <= 'b0;
            remainder_reg <= 'b0;
            count <= 'b0;
            done_reg <= 1'b0;
        end
        else begin
            case(state)
                IDLE: begin
                    if(start) begin
                        state <= CALC;
                        dividend_reg <= dividend; // Load dividend
                        divisor_reg <= divisor;   // Load divisor
                        quotient_reg <= 'b0; // Reset quotient
                        remainder_reg <= 'b0; // Reset remainder
                        count <= 'b0; // Reset count
                        done_reg <= 1'b0; // Reset done signal
                    end
                end

                CALC: begin
                    if(count < M) begin
                        if({remainder_reg[M-2:0], dividend_reg[N-1]} >= divisor_reg) begin
                            remainder_reg <= {remainder_reg[M-2:0], dividend_reg[N-1]} - divisor_reg; // Update remainder
                            quotient_reg <= {quotient_reg[M-2:0], 1'b1}; // Set quotient bit
                        end
                        else begin
                            remainder_reg <= {remainder_reg[M-2:0], dividend_reg[N-1]}; // Update remainder
                            quotient_reg <= {quotient_reg[M-2:0], 1'b0};
                        end
                        dividend_reg <= {dividend_reg[N-2:0], 1'b0}; // Shift dividend left
                        count <= count + 1'b1; // Increment count
                    end
                    else begin
                        done_reg <= 1'b1; // Set done signal
                        state <= DONE; // Move to DONE state
                    end
                end

                DONE: begin
                    if(!start) begin
                        state <= IDLE; // Reset state to IDLE
                    end
                end

            endcase
        end
    end

    assign quotient = quotient_reg;
    assign remainder = remainder_reg;
    assign done = done_reg;
    assign cnt = count;

endmodule
