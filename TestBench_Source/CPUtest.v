

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 19:07:09
// Design Name: 
// Module Name: CPUtest
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


module CPUtest(
    output wire[31:0] result
);

    reg clk;//时钟
    reg rstn;//reset

    wire[31:0] instruct;//指令

    wire[31:0] nowPc;//目前正在执行得指令地址
    wire[31:0] nextPc;//下一条指令地址
    wire clear;//清空

    wire[4:0] Wadd;//写reg得地址
    wire[4:0] Radd1;//读出rs1的地址
    wire[4:0] Radd2;//读出rs2的地址


    wire[31:0] rs1;
    wire[31:0] rs2;
    wire[31:0] rs1_in;
    wire[31:0] rs2_in;
    wire[31:0] rs1_out;
    wire[31:0] rs2_out;
    wire[31:0] Wdata;//bus_w
    //wire[31:0] result;//bus_wo
    wire[31:0] dataout;


    wire[31:0] imm;


    wire jump;
    wire isWreg;
    wire isWmem;
    wire mrs1andpc_ctr;
    wire mrs1andpc_ctr2;
    wire zero;


    wire[1:0] branch;
    wire[5:0] ALUctr;
    wire[1:0] mrs2andie_ctr;
    wire[2:0] maluandmem_ctr;
    wire[1:0] mrs2_ctr;
    wire[2:0] exop;
    initial begin
        clk=0;
        rstn=0;
        #10
        rstn=1'b1;
    end
    always #10 clk=~clk;


    //*******取指******************************************************
    PC PC0(
        .clk(clk),
        .rstn(rstn),
        .nextPc(nextPc),

        .nowPc(nowPc),
        .clear(clear)
    );

    pcAdder pcAdder0(
        .nowPc(rs1_out),
        .imm(imm),
        .branch(branch),
        .result(Wdata[0]),
        .zero(zero),
        .jump(jump),

        .nextPc(nextPc)
    );

    instMem instMem0(
        .clear(clear),
        .address(nowPc),

        .instruct(instruct)
    );
    //*******取指*****************************************************

    //*******译码*****************************************************
    ID ID0(
        .rstn(rstn),
        .instruct(instruct),

        .Wadd(Wadd),
        .Radd1(Radd1),
        .Radd2(Radd2),

        .branch_o(branch),
        .jump_o(jump),
        .isWreg(isWreg),
        .isWmem(isWmem),
        .mrs1andpc_ctr(mrs1andpc_ctr),
        .mrs1andpc_ctr2(mrs1andpc_ctr2),
        .maluandmem_ctr(maluandmem_ctr),

        .exop(exop),
        .alu_ctr_o(ALUctr),
        .mrs2andie_ctr(mrs2andie_ctr),
        .mrs2_ctr(mrs2_ctr)
    );
    //*******译码*****************************************************

    //*******立即数*****************************************************
    IE IE0(
        .instruct(instruct),
        .exop(exop),
        .imm(imm)
    );
    //*******立即数*****************************************************


    //*******访存*****************************************************
    regFile regFile0(
        .clk(clk),
        .rstn(rstn),
        .Wadd(Wadd),
        .Wdata(result),
        .isWreg(isWreg),
        .Radd1(Radd1),
        .Radd2(Radd2),

        .Rdata1(rs1),
        .Rdata2(rs2)
    );
    //*******访存*****************************************************
    

    //*****rs1还是pc到ALU**************
    mux_From_rs1_PC_To_ALU mux_From_rs1_PC_To_ALU0(
        .mrs1andpc_ctr(mrs1andpc_ctr),
        .rs1(rs1),
        .pc(nowPc),

        .mrs1andpc_out(rs1_in)
    );
    //*****rs1还是pc到ALU**************

    //*****rs2还是imm到ALU**************
    mux_From_rs2_IE_To_ALU mux_From_rs2_IE_To_ALU0(
        .mrs2andie_ctr(mrs2andie_ctr),
        .rs2(rs2),
        .imm(imm),

        .mrs2andie_out(rs2_in)
    );
    //*****rs2还是imm到ALU**************


    //****ALU计算*****************************************************
    ALU ALU0(
        .rs1(rs1_in),
        .rs2(rs2_in),
        .ALUctr(ALUctr),

        .res(Wdata),
        .zero(zero)
    );
    //****ALU计算**************************************************

    //***下一个pc是否跳转***********************************
    mux_From_PC_rs1_To_PC mux_From_PC_rs1_To_PC0(
        .mrs1andpc_ctr2(mrs1andpc_ctr2),
        .pc(nowPc),
        .rs1(rs1),

        .mrs1andpc_out(rs1_out)
    );
    
    //***下一个pc是否跳转***********************************

    //***存mem*************************************************
    mux_From_rs2_To_mem mux_From_rs2_To_mem0(
        .mrs2_ctr(mrs2_ctr),
        .rs2(rs2),
        
        .mrs2_out(rs2_out)
    );
    //***存mem*************************************************

    //***存reg**************************************************
    mux_From_ALU_mem_ToReg mux_From_ALU_mem_ToReg0(
        .maluandmem_ctr(maluandmem_ctr),
        .ALU_result(Wdata),
        .mem_data(dataout),

        .maluandmem_out(result)
    );
    //***存reg**************************************************

    //***存储器**************************************************
    dataMem dataMem0(
        .rstn(rstn),
        .clk(clk),
        .isWmem(isWmem),
        .address(Wdata),
        .dataW(rs2_out),
        
        .dataR(dataout)
        
    );
    //***存储器**************************************************

    


endmodule
