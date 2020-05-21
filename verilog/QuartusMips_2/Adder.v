module Adder(
	input[31:0] entrPc,
	input[31:0] entrShift,
	output[31:0] ResBranch
);

assign ResBranch = entrPc + entrShift;

endmodule 