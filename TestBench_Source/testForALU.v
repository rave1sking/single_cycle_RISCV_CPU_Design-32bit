`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 20:55:17
// Design Name: 
// Module Name: testForALU
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


module testForALU;
    reg[5:0] ALUctr;
    reg[31:0] rs1;
    reg[31:0] rs2;
    wire[31:0] res;
    initial begin
        ALUctr=6'b000000;
        rs1=32'b0000_0000_0000_0000_0000_0000_0000_0010;
        rs2=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        #100
        ALUctr=6'b000001;
        rs1=32'b0000_0000_0000_0000_0000_0000_0000_0011;
        rs2=32'b0000_0000_0000_0000_0000_0000_0000_0010;
    end
    ALU ALU0(
        .ALUctr(ALUctr),
        .rs1(rs1),
        .rs2(rs2),
        .res(res)
    );
endmodule
