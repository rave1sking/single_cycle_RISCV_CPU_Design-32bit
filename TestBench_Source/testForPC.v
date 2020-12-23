`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 21:45:43
// Design Name: 
// Module Name: testForPC
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


module testForPC;

wire [31:0] nowPc;
wire [31:0] instruct;
wire [31:0] nextPc;
reg clk;
reg rstn;
reg clear;
reg jump;
reg [31:0] imm;
initial begin
    clk=0;
    rstn=0;
    jump=0;
    #10
    rstn=1'b1;
    clear=1'b1;

    #10 
    jump=1'b1;
    imm=32'b0000_0000_0000_0000_0000_0000_0000_1000;

    #10
    jump=0;
end
always #10 clk=~clk;

    pcAdder pcAdder0(
        .nowPc(nowPc),
        .nextPc(nextPc),
        .clear(clear),
        .jump(jump),
        .imm(imm)
    );
    instMem instMem0(
        .clear(clear),
        .address(nowPc),
        .instruct(instruct)
    );
    PC PC(
        .rstn(rstn),
        .clk(clk),
        .nextPc(nextPc),
        .nowPc(nowPc)
    );
endmodule
