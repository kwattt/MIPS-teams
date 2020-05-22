module buffer2 (
	input clk,
	input [15:11]en1,
	input [20:16]en2,
	input [31:0]sing_ex,
	input [31:0]data1,
	input [31:0]data2,
	input [31:0]add_pc,
	input [31:0]SingJump,
	input RegDst,
	input ALUSrc,
	input [2:0]AluOP,
	input Branch,
	input MemRead,
	input Jump,
	input MemWrite,
	input MemtoReg,
	input RegWrite,

	output reg sal_RegWrite,
	output reg sal_MemtoReg,
	output reg sal_MemWrite,
	output reg sal_Jump,
	output reg sal_MemRead,
	output reg sal_Branch,
	output reg[2:0]sal_AluOP,
	output reg sal_ALUSrc,
	output reg sal_RegDst,
	output reg[31:0]sal_addPc,
	output reg[31:0]sal_SingJump,
	output reg[31:0]data1_salida,
	output reg[31:0]data2_salida,
	output reg[31:0]sal_singEx,
	output reg[15:11]salida1,
	output reg[20:16]salida2
);

always @(posedge clk)
begin	
	sal_RegWrite <= RegWrite;
	sal_MemtoReg <= MemtoReg; 
	sal_MemWrite <= MemWrite;
	sal_Jump <= Jump;
	sal_MemRead <= MemRead;
	sal_Branch <= Branch;
	sal_AluOP <= AluOP;
	sal_ALUSrc <= ALUSrc;
	sal_RegDst <= RegDst;
	sal_addPc <= add_pc;
	sal_SingJump <= SingJump; 
	data1_salida <= data1;
	data2_salida <= data2;
	sal_singEx <= sing_ex;
	salida1 <= en1;
	salida2 <= en2;
end

endmodule