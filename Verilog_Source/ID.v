`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/10 14:37:17
// Design Name: 
// Module Name: ID
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


module ID(
        input    rstn,
        input [31:0] instruct,
        output reg [4:0]  Radd1,   // readAddress
        output reg [4:0]  Radd2,
        
        output reg [4:0] Wadd,     //writeAddress
        
        // 单值控制信号
        output reg jump_o,         //pc跳转指令
        output reg isWreg,         // Reg
        output reg isWmem,         // Mem
        output reg mrs1andpc_ctr,  //选择rs1还是pc的值到ALU,0时选择rs1; 1时选择pc
        output reg mrs1andpc_ctr2, //选择rs1的结果还是PC的结果送到PC

        //多值控制信号
        output reg [1:0] branch_o,          //pc分支控制信号
        //branch_o:
        //
        //
        output reg [1:0] mrs2andie_ctr,     //选rs2还是立即数到ALU,00时选择rs2; 01时赋定值4; 10时选择imm（立即数）
        output reg [2:0] exop,              // 立即数扩展信号
        output reg [5:0] alu_ctr_o,         //ALU控制信号
        output reg [1:0] mrs2_ctr,          //变化rs2送到存储器
        output reg [2:0] maluandmem_ctr     //多路选择器，选择ALU的输出还是存储器的输出到reg     
    );
    
    wire [6:0] opcode = instruct[6:0];      //opcode
    wire [2:0] f3 = instruct[14:12];        //func3
    wire [6:0] f7 = instruct[31:25];        //func7

    
    always @(*) begin //任意一种变化都会触发
          if (~rstn) begin
              Wadd <= 0;
              Radd1 <= 0;
              Radd2 <= 0;
          end
          // 译码
          else begin
                //初始化:
               jump_o<=(opcode[6] & opcode[5] & ~opcode[4] & opcode[3] & opcode[2] & opcode[1] & opcode[0]) //1101111 jal
               | (opcode[6] & opcode[5] & ~opcode[4] & ~opcode[3] & opcode[2] & opcode[1] & opcode[0]);     //1100111jalr            // J-type
               Wadd  <= instruct[11:7];
               Radd1 <= instruct[19:15];
               Radd2 <= instruct[24:20];
               isWreg = 0;
               isWmem = 0;
               mrs1andpc_ctr  <= 0;
               mrs1andpc_ctr2 <= 0;
               branch_o = 2'b00; //不译码
               alu_ctr_o <= 5'b011000;
               mrs2andie_ctr  <= 2'b00;
               exop = 3'b111;
               mrs2_ctr = 0;
               maluandmem_ctr <= 2'b000;
               case(opcode)
                  7'b0110011: begin  //R型指令
                     mrs1andpc_ctr  <= 0;
                     mrs2andie_ctr  <= 2'b00;
                     maluandmem_ctr <= 2'b000;
                     mrs1andpc_ctr2<=0;
                     isWreg = 1;
                     case(f7)
                         7'b0000000: begin
                             case(f3)
                                 3'b000: begin
                                     alu_ctr_o <= 6'b000000; //add
                                 end
                                 3'b111: begin
                                     alu_ctr_o <= 6'b000001; //and
                                 end
                                 3'b110: begin
                                     alu_ctr_o <= 6'b000010; //or 
                                 end
                                 3'b100: begin
                                     alu_ctr_o <= 6'b000011; //xor
                                 end
                                 3'b101: begin
                                     alu_ctr_o <= 6'b000100; //srl
                                 end
                                 3'b001: begin
                                     alu_ctr_o <= 6'b000101; //sll
                                 end
                                 3'b010: begin
                                     alu_ctr_o <= 6'b000110; //slt
                                 end
                                 3'b011:begin
                                     alu_ctr_o <= 6'b000111; //sltu
                                 end
                             endcase
                         end
                          7'b0000001: begin
                               case(f3)
                                   3'b100: begin
                                       alu_ctr_o <= 6'b001000; //div
                                   end
                                   3'b101: begin
                                       alu_ctr_o <= 6'b001001; //divide unsigned
                                   end
                                   3'b000: begin
                                       alu_ctr_o <= 6'b001010; //mul
                                   end
                                   3'b001: begin
                                       alu_ctr_o <= 6'b001011; //mulh
                                   end
                                   3'b010: begin
                                       alu_ctr_o <= 6'b001100;  //mulhsu
                                   end
                                   3'b011: begin
                                       alu_ctr_o <= 6'b001101;  //mulhu
                                   end
                                   3'b110: begin
                                       alu_ctr_o <= 6'b001110; //rem
                                   end
                                   3'b111: begin
                                       alu_ctr_o <= 6'b001111; //remu
                                   end
                               endcase
                           end
                           7'b0100000:  begin
                               case(f3)
                                  3'b101: begin
                                      alu_ctr_o <= 6'b010000; //sra
                                  end
                                  3'b000: begin
                                      alu_ctr_o <= 6'b010001; //sub
                                  end
                               endcase
                           end
                     endcase
                  end
                  7'b0010011: begin     //I型指令
                      //立即数扩展
                      //给IE  exop[2:0] 和 instruct
                      mrs1andpc_ctr  <= 0;
                      mrs2andie_ctr  <= 2'b10;
                      maluandmem_ctr <= 2'b000;
                      mrs1andpc_ctr2<=0;
                      case(f3) 
                            3'b000: begin 
                                exop <= 3'b000;
                                alu_ctr_o <= 6'b000000; //addi
                            end
                            3'b111: begin
                                exop <= 3'b000;
                                alu_ctr_o <= 6'b000001; //andi
                            end
                            3'b110: begin
                                exop <= 3'b000;
                                alu_ctr_o <= 6'b000010; //ori
                            end
                            3'b001: begin
                                case(f7) 
                                  7'b0000000:begin
                                      exop <= 3'b101;
                                      alu_ctr_o <= 6'b010010; //slli
                                  end
                                endcase
                            end
                            3'b010: begin
                                exop <= 3'b000;
                                alu_ctr_o <= 6'b010011; //slti
                            end
                            3'b011: begin
                                exop <= 3'b110;
                                alu_ctr_o <= 6'b010011; //sltiu
                            end
                            
                            3'b101: begin
                               case(f7) 
                                  7'b0100000:begin
                                      exop <= 3'b101;
                                      alu_ctr_o <= 6'b010100; //srai
                                  end
                               endcase  
                            end
                            3'b100: begin
                                exop <= 3'b000;
                                alu_ctr_o <= 0'b00011; //xori
                            end                            
                      endcase
                  end

                  7'b0010111: begin
                        exop <= 3'b001;
                        alu_ctr_o <= 6'b000000;
                        mrs1andpc_ctr <= 1;
                        mrs2andie_ctr <=  2'b10;
                  end
                  // I型 
                  7'b0000011: begin
                      mrs1andpc_ctr  <= 0;  //选择rs1 0 还是pc 1的值到ALU
                      mrs2andie_ctr  <= 2'b10; //选择立即数
                      isWreg<=1'b1;
                      case(f3) 
                          3'b000: begin    //取八位，符号扩展
                              exop <= 3'b000;
                              alu_ctr_o <= 6'b0000000;  //lb
                              maluandmem_ctr = 3'b010;  //选择ALU的输出,还是Mem的输出到reg
                          end
                          // 取八位，零扩展
                          3'b100: begin
                              exop <= 3'b000;
                              alu_ctr_o <= 6'b000000;
                              maluandmem_ctr = 3'b100;
                          end 
                          3'b001: begin //取十六位，符号扩展
                              exop <= 3'b000;
                              alu_ctr_o <= 6'b000000;
                              maluandmem_ctr = 3'b011;
                          end
                          3'b101: begin //取十六位，零扩展
                              exop <= 3'b000;
                              alu_ctr_o <= 6'b000000;
                              maluandmem_ctr = 3'b101;
                          end
                          3'b010: begin //取字
                              exop <= 3'b000;
                              alu_ctr_o <= 6'b000000;
                              maluandmem_ctr = 3'b001;
                          end
                          3'b110: begin //无符号取字?
                              exop <= 3'b000;
                              alu_ctr_o <= 6'b000000;
                              maluandmem_ctr = 3'b001;                         
                          end
                      endcase

                  end
                   7'b0100011: begin    //s型
                      mrs1andpc_ctr  <= 0;
                      mrs2andie_ctr  <= 2'b10;
                      maluandmem_ctr <= 2'b000;
                      mrs1andpc_ctr2<=0;
                      isWmem = 1;
                      exop <= 3'b010;
                      case(f3)
                         3'b010: begin
                              alu_ctr_o <= 6'b000000;
                              mrs2_ctr = 2'b00;    //sw
                         end

                         3'b000: begin
                             alu_ctr_o <= 6'b000000;  
                             mrs2_ctr = 2'b10;     //sb
                         end
                         3'b001: begin
                             alu_ctr_o <= 6'b000000;  
                             mrs2_ctr = 2'b11;     //sh
                         end
                      endcase
                   end
                   7'b1100011: begin
                      alu_ctr_o <= 6'b010001; //sub 通过减两个寄存器的值进行判断
                      exop <= 3'b011;
                      mrs2andie_ctr<=2'b00;
                      case(f3)
                            3'b000: begin              //beq:x[rs1]和寄存器 x[rs2]的值相等,把 pc 的值设为当前值加上符号位扩展的偏移 offset
                               branch_o = 2'b01;
                            end
                            3'b101: begin
                                branch_o = 2'b11;
                                alu_ctr_o <= 6'b010101;
                            end
                            3'b111: begin
                                branch_o <= 2'b11;     //bgeu:if (rs1 ≥urs2) pc += sext(offset)
                                alu_ctr_o <= 6'b010101;
                            end
                            3'b100: begin
                                alu_ctr_o <= 6'b010110;
                                branch_o <= 2'b11;     //blt: if (rs1 <srs2) pc += sext(offset)
                            end
                            3'b110: begin
                                alu_ctr_o <= 6'b010110;
                                branch_o <= 2'b11;
                            end      
                            3'b001: begin
                                branch_o <= 2'b10;
                            end
                      endcase
                    end
                     7'b1101111: begin      //jal: jmp_o = 1 PC+IMM
                        exop <= 3'b100;     //送到pc_addr   
                        mrs2andie_ctr <= 2'b01; //送到ALU的两个信号: PC和4
                        mrs1andpc_ctr <= 1;     //选PC
                    end
                    
                    //jalr
                    7'b1100111: begin
                        case(f3) 
                             3'b010: begin
                                 exop<=3'b000;
                                 mrs1andpc_ctr <= 1;
                                 mrs2andie_ctr <= 2'b01;
                                 mrs1andpc_ctr2<=1;
                             end
                        endcase
                    end

                    7'b0110111: begin    //高位扩展 x[rd] = sext(immediate[31:12] << 12)
                         exop <= 3'b001;
                         alu_ctr_o <= 6'b010111;//rd = rs2
                         mrs2andie_ctr<=2'b10;
                         isWreg<=1'b1;
                    end
            endcase
         end  //else
    end   //always
endmodule
