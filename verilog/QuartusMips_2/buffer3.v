module buffer3(

	input clk,
	input ReadWrite,
	input MemtoReg,
	input MenWrite,
	input MemRead,
	input Branch,
	input [31:0]OutBranch,
	input zflag,
	input [31:0]AleReg,
	input [31:0]Data2,
	input [4:0]writeReg,
	
	output reg sal_ReadWrite,
	output reg sal_MemtoReg,
	output reg sal_MemWrite,
	output reg sal_MemRead,
	output reg [31:0]sal_Branch,
	output reg sal_zflag,
	output reg [31:0]sal_AluRes,
	output reg [31:0]sal_Data2,
	output reg sal_writeReg
);

always @(posedge clk)
begin
	sal_ReadWrite <= ReadWrite;
	sal_MemtoReg <= MemtoReg;
	sal_MemWrite <= MenWrite;
	sal_MemRead <= MemRead;
	sal_Branch <= Branch;
	sal_zflag <= zflag;
	sal_AluRes <= AleReg;
	sal_Data2 <= Data2;
	sal_writeReg <= writeReg;
end

endmodule 
	