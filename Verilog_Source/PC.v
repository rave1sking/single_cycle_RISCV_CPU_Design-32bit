`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 21:00:54
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,//CPU时钟
    input rstn,//reset信号              
    input [31:0] nextPc,//下一条指令的地址

    output reg [31:0] nowPc,//目前指令的地址
    output reg clear//归零信号
    );

    always @(posedge clk or negedge rstn) begin
        if(~rstn)
            clear<=1'b0;
        else
            clear<=1'b1;
    end
    always @(posedge clk) begin
        if(~clear)
            nowPc<=32'b0;
        else
            nowPc<=nextPc;
    end
endmodule
