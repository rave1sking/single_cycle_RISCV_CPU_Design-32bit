`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 14:33:11
// Design Name: 
// Module Name: testFormux_From_ALU_mem_To_reg
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


module testFormux_From_ALU_mem_To_reg;

    reg [2:0] maluandmem_ctr;
    reg [31:0] ALU_result;
    reg [31:0] mem_data;

    wire [31:0] maluandmem_out;

    mux_From_ALU_mem_To_reg mux_From_ALU_mem_To_reg0(
        .maluandmem_ctr(maluandmem_ctr),
        .ALU_result(ALU_result),
        .mem_data(mem_data),
        .maluandmem_out(maluandmem_out)
    );

    initial begin
        maluandmem_ctr=3'b000;
        ALU_result=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        mem_data=32'b0000_0000_0000_0000_0000_0000_0000_0010;
        
        #10
        maluandmem_ctr=3'b001;
        #10
        maluandmem_ctr=3'b010;
    end

endmodule
