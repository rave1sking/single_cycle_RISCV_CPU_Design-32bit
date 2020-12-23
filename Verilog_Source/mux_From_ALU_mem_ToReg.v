`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 14:24:02
// Design Name: 
// Module Name: mux_From_ALU_mem_ToReg
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


module mux_From_ALU_mem_ToReg(
    input  [2:0] maluandmem_ctr,
    input  [31:0] ALU_result,
    input  [31:0] mem_data,

    output reg [31:0] maluandmem_out
    );

    always @( *) begin
        case (maluandmem_ctr)
            3'b000:begin
                maluandmem_out<=ALU_result;
            end

            3'b001:begin
                maluandmem_out<=mem_data;
            end
            3'b010: begin  
				maluandmem_out <= {{24{mem_data[7]}}, mem_data[7:0]};
			end
			3'b011: begin  
				maluandmem_out <= {{16{mem_data[15]}}, mem_data[15:0]};
			end
			3'b100: begin  
				maluandmem_out <= {24'b0, mem_data[7:0]};
			end
			3'b101: begin
				maluandmem_out <= {16'b0, mem_data[15:0]};
            end
        endcase
    end
endmodule
