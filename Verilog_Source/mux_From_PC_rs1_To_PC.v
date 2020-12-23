`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 14:52:21
// Design Name: 
// Module Name: mux_From_PC_rs1_To_PC
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


module mux_From_PC_rs1_To_PC(
    input mrs1andpc_ctr2,
    input [31:0] pc,
    input [31:0] rs1,

    output reg [31:0] mrs1andpc_out
    );

    always @(*) begin
        case(mrs1andpc_ctr2)
            1'b0:begin
                mrs1andpc_out<=pc;
            end
            1'b1:begin
                mrs1andpc_out<=rs1;
            end
        endcase
    end
endmodule
