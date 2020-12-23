`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 14:57:19
// Design Name: 
// Module Name: testFormux_From_PC_rs1_To_PC
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


module testFormux_From_PC_rs1_To_PC;
    reg mrs1andpc_ctr2;
    reg [31:0]pc;
    reg [31:0]rs1;
    wire [31:0]mrs1andpc_out;

    mux_From_PC_rs1_To_PC mux_From_PC_rs1_To_PC0(
        .mrs1andpc_ctr2(mrs1andpc_ctr2),
        .pc(pc),
        .rs1(rs1),
        .mrs1andpc_out(mrs1andpc_out)
    );

    initial begin
        pc=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        rs1=32'b0000_0000_0000_0000_0000_0000_0000_0010;
        mrs1andpc_ctr2=1'b0;

        #10
        mrs1andpc_ctr2=1'b1;
    end
endmodule
