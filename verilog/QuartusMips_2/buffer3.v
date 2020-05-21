module buffer3(

	input clk,
	input RegWrite,
	input MemtoReg,
	input Jump,
	input MemWrite,
	input MemRead,
	input Branch,
	input [31:0]JumpV,
	input [31:0]OutBranch,
	input zflag,
	input [31:0]AluRes,
	input [31:0]Data2,
	input [4:0]writeReg,
	
	output reg sal_RegWrite,
	output reg sal_MemtoReg,
	output reg sal_Jump,
	output reg sal_MemWrite,
	output reg sal_MemRead,
	output reg sal_Branch,
	output reg [31:0]sal_JumpV,
	output reg [31:0]sal_OutBranch,
	output reg sal_zflag,
	output reg [31:0]sal_AluRes,
	output reg [31:0]sal_Data2,
	output reg [4:0]sal_writeReg
);

always @(posedge clk)
begin
	sal_RegWrite <= RegWrite;
	sal_MemtoReg <= MemtoReg;
	sal_Jump <= Jump;
	sal_MemWrite <= MemWrite;
	sal_MemRead <= MemRead;
	sal_Branch <= Branch;
	sal_JumpV <= JumpV; 
	sal_OutBranch <= OutBranch;
	sal_zflag <= zflag;
	sal_AluRes <= AluRes;
	sal_Data2 <= Data2;
	sal_writeReg <= writeReg;
end

endmodule 
	