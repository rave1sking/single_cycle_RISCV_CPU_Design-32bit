`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/05 14:08:28
// Design Name: 
// Module Name: dataMem
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


module dataMem(
    input  rstn,
    input  clk,
    input  isWmem,//写使能信号
    input  [31:0] address,//要写入的地址
    input  [31:0] dataW,//要写入的数据
    output reg  [31:0] dataR//读出的数据
    );

    reg [31:0] mem[0:255];
    //initial $readmemh ("C:/Users/MECHREKVO/Desktop/RISCV_CPU/data.txt", mem);
    /*always @(posedge clk or negedge rstn) begin
        if(rstn&&isWmem)
            mem[address[9:2]]<=dataW;
    end*/
    always @(*) begin
        if(~rstn)begin
            mem[0]<=32'd1;
            mem[1]<=32'd2;
            mem[2]<=32'd3;
            mem[3]<=32'd4;
            mem[4]<=32'd5;
            mem[5]<=32'd6;
            mem[6]<=32'd7;
            mem[7]<=32'd8;
            mem[8]<=32'd9;
            mem[9]<=32'd10;
            dataR<=32'b0;
        end
        else 
            dataR<=mem[address[9:2]];
    end
endmodule
