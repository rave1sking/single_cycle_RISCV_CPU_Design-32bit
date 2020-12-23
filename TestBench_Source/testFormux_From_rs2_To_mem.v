`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 15:12:30
// Design Name: 
// Module Name: testFormux_From_rs2_To_mem
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


module testFormux_From_rs2_To_mem;
    reg[1:0] mrs2_ctr;
    reg[31:0] rs2;
    wire[31:0] mrs2_out;

    mux_From_rs2_To_mem mux_From_rs2_To_mem0(
        .mrs2_ctr(mrs2_ctr),
        .rs2(rs2),
        .mrs2_out(mrs2_out)
    );

    initial begin
        mrs2_ctr=2'b00;
        rs2=32'b0000_0000_0000_0000_0000_0000_0000_0001;

        #10;
        mrs2_ctr=2'b01;
        rs2=32'b0000_0000_0000_0000_0000_0000_1111_0001;
    end
endmodule
