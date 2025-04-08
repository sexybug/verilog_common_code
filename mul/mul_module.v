`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/08 14:06:20
// Design Name: 
// Module Name: mul_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: P = A * B
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mul_module
#(
    parameter A_WIDTH = 64,
    parameter B_WIDTH = 64,
    parameter P_WIDTH = A_WIDTH + B_WIDTH
)
(
    input clk,
    input rst,
    input start,
    input [A_WIDTH-1:0] A,
    input [B_WIDTH-1:0] B,
    output [P_WIDTH-1:0] P,
    output done,
    output [7:0] cnt
    );

    reg [1:0] state;
    localparam IDLE = 2'b00;
    localparam CALC = 2'b01;
    localparam DONE = 2'b10;

    reg [B_WIDTH-1:0] B_reg;
    reg [P_WIDTH-1:0] P_reg;
    reg done_reg;
    reg [7:0] count;

    always@(posedge clk, posedge rst) begin
        if(rst) begin
            state <= IDLE;
            B_reg <= 'b0;
            P_reg <= 'b0;
            count <= 'b0;
            done_reg <= 1'b0;
        end
        else begin
            case(state)
                IDLE: begin
                    if(start) begin
                        B_reg <= B;
                        P_reg <= 'b0;
                        count <= 'b0;
                        done_reg <= 1'b0;
                        state <= CALC;
                    end
                end

                CALC: begin
                    if(count < B_WIDTH) begin
                        P_reg <= {P_reg[P_WIDTH-2:0], 1'b0} + (B_reg[B_WIDTH-1] ? {{B_WIDTH{1'b0}}, A} : {P_WIDTH{1'b0}});
                        B_reg <= {B_reg[B_WIDTH-2:0], 1'b0}; // Shift B_reg left by 1 bit
                        count <= count + 1;
                    end
                    else begin
                        done_reg <= 1'b1;
                        state <= DONE;
                    end
                end

                DONE: begin
                    if(!start) begin
                        state <= IDLE;
                    end
                end

                default: state <= IDLE; // Default case to handle unexpected states
            endcase
        end
    end

    assign P = P_reg;
    assign done = done_reg;
    assign cnt = count;

endmodule
