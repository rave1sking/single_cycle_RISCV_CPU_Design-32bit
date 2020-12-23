`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 21:20:04
// Design Name: 
// Module Name: instMem
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


module instMem(
    input  clear,
    input  [31:0] address,

    output reg [31:0] instruct
    );
    reg [31:0] instMem_text[0:255];
    
    always @( *) begin
        if(~clear)begin
            instMem_text[0]<=32'h00000037;
            instMem_text[1]<=32'h000000b7;
            instMem_text[2]<=32'h02002103;
            instMem_text[3]<=32'h000001B7;
            instMem_text[4]<=32'h00402203;
            instMem_text[5]<=32'h000002B7;
            instMem_text[6]<=32'h00000337;
            instMem_text[7]<=32'h00802383;
            instMem_text[8]<=32'h00000437;
            instMem_text[9]<=32'h000004B7;
            instMem_text[10]<=32'h00000537;
            instMem_text[11]<=32'h00C02583;
            instMem_text[12]<=32'h000004B3;
            instMem_text[13]<=32'h001102B3;
            instMem_text[14]<=32'h0242C1B3;
            instMem_text[15]<=32'h02B181B3;
            instMem_text[16]<=32'h0001A303;
            instMem_text[17]<=32'h02730263;
            instMem_text[18]<=32'h00735463;
            instMem_text[19]<=32'h00734863;
            instMem_text[20]<=32'h00300133;
            instMem_text[21]<=32'h02B14133;
            instMem_text[22]<=32'hFDDFF46F;
            instMem_text[23]<=32'h003000B3;
            instMem_text[24]<=32'h02B0C0B3;
            instMem_text[25]<=32'hFD1FF46F;
            instMem_text[26]<=32'h003004B3;
            instMem_text[27]<=32'h02B4C4B3;
        end
    end
    
    //initial $readmemh("C:/Users/MECHREKVO/Desktop/RISCV_CPU/instruct.txt",instMem_text);

    always @(*) begin
        if(~clear)
            instruct<=0;
        else
            instruct<=instMem_text[address[9:2]];
    end
endmodule
