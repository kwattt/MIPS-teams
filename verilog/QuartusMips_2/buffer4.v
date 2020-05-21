module buffer4 (
	input clk,
	input RegWrite,
	input MemToReg,
	input [31:0] MemRes,
	input [31:0] AluRes,
	input [4:0]WriteRegister,

	output reg sal_RegWrite,
	output reg sal_MemToReg,
	output reg[31:0] sal_MemRes,
	output reg[31:0]  sal_AluRes,
	output reg[4:0] sal_WriteReg

);

always @(posedge clk)
begin
	sal_RegWrite <= RegWrite;	
	sal_MemToReg <= MemToReg;
	sal_MemRes <= MemRes;
	sal_AluRes <= AluRes;
	sal_WriteReg <= WriteRegister;
end

endmodule 