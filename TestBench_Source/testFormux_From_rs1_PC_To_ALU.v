`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 14:16:18
// Design Name: 
// Module Name: testFormux_From_rs1_PC_To_ALU
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


module testFormux_From_rs1_PC_To_ALU;

    reg mrs1andpc_ctr;
    reg [31:0] rs1;
    reg [31:0] pc;
    wire [31:0] mrs1andpc_out;
    mux_From_rs1_PC_To_ALU mux_From_rs1_PC_To_ALU0(
        .mrs1andpc_ctr(mrs1andpc_ctr),
        .rs1(rs1),
        .pc(pc),
        .mrs1andpc_out(mrs1andpc_out)
    );
    initial begin
        mrs1andpc_ctr=1'b0;
        rs1=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        pc=32'b0000_0000_0000_0000_0000_0000_0000_0010;
        #10
        mrs1andpc_ctr=1'b1;
    end

endmodule
