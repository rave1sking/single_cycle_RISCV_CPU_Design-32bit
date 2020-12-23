`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/11 17:19:37
// Design Name: 
// Module Name: IE
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


module IE(
    input  [31:0] instruct,
    input  [2:0] exop,
    output reg[31:0] imm
    );
    always @(*) begin
        case (exop)
            3'b000: begin // ori lw immI
            imm <= {{20{instruct[31]}} , instruct[31:20]};
            end
            3'b001: begin // lui immU 
                imm <= {instruct[31:12], 12'b0};
            end
            3'b010: begin // sw immS
                imm <= {{20{instruct[31]}}, instruct[31:25], instruct[11:7]};
            end
            3'b011: begin // beq immB
                imm <= {{20{instruct[31]}}, instruct[7], instruct[30:25], instruct[11:8], 1'b0};
            end
            3'b100: begin // jal immJ
                imm <= {{12{instruct[31]}}, instruct[19:12], instruct[20], instruct[30:21], 1'b0};
            end
            3'b101: begin // slli
                imm <= {{27{instruct[31]}}, instruct[24:20]};
            end
            3'b110: begin // 无符号扩展31:20立即数
                imm <= {20'b0 , instruct[31:20]};
            end

        endcase
    end

endmodule
