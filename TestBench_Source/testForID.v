`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 13:37:01
// Design Name: 
// Module Name: testForID
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


module testForID;

    wire[4:0] Radd1;
    wire[4:0] Radd2;
    reg[31:0] instruct;
    wire [5:0] alu_ctr_o;
    reg rstn;
    ID ID0(
        .rstn(rstn),
        .instruct(instruct),
        .Radd1(Radd1),
        .Radd2(Radd2),
        .alu_ctr_o(alu_ctr_o)
    );
    initial begin
        rstn=0;
        #10;
        rstn=1'b1;
        instruct=32'b0000_0000_0010_0000_1111_0000_0011_0011;
    end

endmodule
