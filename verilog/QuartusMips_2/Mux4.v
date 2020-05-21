module Mux4(
	input [31:0]AluRes0,
	input [31:0]MemRes1,
	input MemtoReg,
	output [31:0]WriteDat
	
);
assign
	WriteDat = (MemtoReg)? MemRes1: AluRes0;

endmodule 