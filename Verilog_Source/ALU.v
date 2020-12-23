`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/05 16:52:41
// Design Name: 
// Module Name: ALU
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


module ALU(
    input  [31:0] rs1,
    input  [31:0] rs2,

    input  [5:0] ALUctr,
    output reg [31:0] res,
    output reg zero
    );
    always @(*) begin
        case(ALUctr)
            6'b000000:begin
                res<=rs1+rs2;
            end
            6'b000001:begin
                res<=rs1&rs2;
            end
            6'b000010:begin
                res<=rs1|rs2;
            end
            6'b000011:begin
                res<=rs1^rs2;
            end
            6'b000100:begin
                res<=rs1>>rs2;
            end
            6'b000101:begin
                res<=rs1<<rs2;
            end
            6'b000110:begin
                if(rs1<rs2)res<=32'b0000_0000_0000_0000_0000_0000_0000_0001;
                else res<=0;
            end
            6'b000111:begin
                if(rs1<rs2)res<=32'b0000_0000_0000_0000_0000_0000_0000_0001;
                else res<=0;
            end
            6'b001000:begin
                res<=rs1/rs2;
            end
            6'b001001:begin
                res<=rs1/rs2;
            end
            6'b001010:begin
                res<=rs1*rs2;
            end
            6'b001011:begin
                res<=rs1*rs2>>32;
            end
            6'b001100:begin
                res<=rs1*rs2>>32;
            end
            6'b001101:begin
                res<=rs1*rs2>>32;
            end
            6'b001110:begin
                res<=rs1%rs2;
            end
            6'b001111:begin
                res<=rs1%rs2;
            end
            6'b010000:begin
                res<=rs1>>rs2;
            end
            6'b010001:begin
                res<=rs1-rs2;
            end
            6'b010010:begin
                res<=rs1<<rs2;
            end
            6'b010011:begin
                if(rs1<rs2)res<=32'b0000_0000_0000_0000_0000_0000_0000_0001;
                else res<=0;
            end
            6'b010100:begin
                res<=rs1>>rs2;
            end
            6'b010101:begin
                res<=(rs1>=rs2);
            end
            6'b010110:begin
                res<=(rs1<rs2);
            end
            6'b010111:begin
                res<=rs2;
            end
        endcase

        if(res==0)zero<=1;
        else zero<=0;
    end
    
endmodule
