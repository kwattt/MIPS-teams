module Mux1(
	input [31:0]ResBranch1,
	input [31:0]ResPc0,
	input PcSrc,
	output [31:0]BResult
	
);
assign
	BResult = (PcSrc)? ResBranch1 : ResPc0;

endmodule 