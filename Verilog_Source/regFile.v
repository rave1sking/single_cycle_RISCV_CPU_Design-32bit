`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 21:36:12
// Design Name: 
// Module Name: regFile
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


module regFile(
    input clk,
    input  rstn,
        
    input[4:0]  Wadd,//要写入的地址
    input[31:0]  Wdata,//要写入的数据
    input  isWreg,//写入的使能信号

    input[4:0] Radd1,//要读取的地址1
    output reg[31:0] Rdata1,//读出的数据1

    input[4:0] Radd2,//要读取的地址2
    output reg[31:0] Rdata2//读出的数据2
    
    );

    reg[31:0] regF[0:31];//32个寄存器


    //initial begin
        //regF[5'b00000]=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        //regF[5'b00001]=32'b0000_0000_0000_0000_0000_0000_0000_0010;
    //end

    always @(posedge clk or negedge rstn) begin//写
        if(rstn&&isWreg)begin
            regF[Wadd]<=Wdata;
        end
    end

    always @(*) begin//读
        if(~rstn)begin
            Rdata1<=32'b0;
            Rdata2<=32'b0;
        end
        else begin
            Rdata1<=regF[Radd1];
            Rdata2<=regF[Radd2];
        end
            
    end


endmodule
