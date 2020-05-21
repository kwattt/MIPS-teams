module Mux_J(
	input [31:0]JumpV1,
	input [31:0]BResult0,
	input Jump,
	output [31:0]Pc
	
);
assign
	Pc = (Jump)? JumpV1 : BResult0;

endmodule 

