`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 14:01:19
// Design Name: 
// Module Name: testFormux_From_rs2_IE_To_ALU
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


module testFormux_From_rs2_IE_To_ALU;

    reg [1:0] mrs2andie_ctr;
    reg [31:0] rs2;
    reg [31:0] imm;
    wire [31:0] mrs2andie_out;

    mux_From_rs2_IE_To_ALU mux_From_rs2_IE_To_ALU0(
        .mrs2andie_ctr(mrs2andie_ctr),
        .rs2(rs2),
        .imm(imm),
        .mrs2andie_out(mrs2andie_out)
    );

    initial begin

        rs2=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        imm=32'b0000_0000_0000_0000_0000_0000_0000_0010;
        mrs2andie_ctr=2'b00;

        #10
        mrs2andie_ctr=2'b01;
        #10
        mrs2andie_ctr=2'b10;
    end


endmodule
