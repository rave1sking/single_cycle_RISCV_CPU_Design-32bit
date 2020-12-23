`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 13:53:08
// Design Name: 
// Module Name:     
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


module mux_From_rs2_IE_To_ALU(
    input  [1:0] mrs2andie_ctr,
    input  [31:0] rs2,
    input [31:0] imm,
    output reg [31:0] mrs2andie_out
    );
    always @( *) begin
        case (mrs2andie_ctr)
            2'b00:begin
                mrs2andie_out<=rs2;
            end
            2'b01:begin
                mrs2andie_out<=4'h4;
            end
            2'b10:begin
                mrs2andie_out<=imm;
            end
        endcase
    end
endmodule
