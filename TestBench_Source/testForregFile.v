`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/10 13:51:27
// Design Name: 
// Module Name: testForregFile
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


module testForregFile;

    reg clk;
    reg rstn;
    reg [4:0] Wadd;
    reg[31:0] Wdata;
    reg isWreg;

    reg[4:0] Radd1;
    wire[31:0] Rdata1;

    reg[4:0] Radd2;
    wire[31:0] Rdata2;

    reg [5:0] ALUctr;

    wire[31:0] result;

    regFile regFile0(
        .clk(clk),
        .rstn(rstn),
        .Wadd(Wadd),
        .Wdata(Wdata),
        .isWreg(isWreg),
        .Radd1(Radd1),
        .Radd2(Radd2),
        .Rdata1(Rdata1),
        .Rdata2(Rdata2)
    );

    ALU ALU0(
        .rs1(Rdata1),
        .rs2(Rdata2),
        .ALUctr(ALUctr),
        .res(result)
    );

    initial begin
        clk=0;
        rstn=0;
        #100;
        rstn=1'b1;
        isWreg=1'b1;
        Wadd=5'b00000;
        Wdata=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        #100;
        Wadd=5'b00001;
        Wdata=32'b0000_0000_0000_0000_0000_0000_0000_0010;

        #100;
        Radd1=5'b00000;
        Radd2=5'b00001;
        ALUctr=6'b000000;

    end

    always #10 clk=~clk;
endmodule
