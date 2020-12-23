`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/05 15:11:44
// Design Name: 
// Module Name: testForDatamem
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


module testForDatamem;
    reg [31:0] address;
    reg [31:0] dataW;
    reg isWmem;
    wire [31:0] dataR;
    reg clk;
    reg rstn;
    initial begin
        clk=0;
        rstn=0;
        #100;
        rstn=1'b1;
        isWmem=1'b1;
        address=32'b0000_0000_0000_0000_0000_0000_0000_1001;
        dataW=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        #100;
        isWmem=1'b0;
        address=32'b0000_0000_0000_0000_0000_0000_0000_0001;
    end
    always #100 clk=~clk;
    dataMem dataMem0(
        .clk(clk),
        .rstn(rstn),
        .address(address),
        .dataW(dataW),
        .dataR(dataR),
        .isWmem(isWmem)
    );

endmodule
