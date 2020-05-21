module Sing_ext(
	input [15:0]entrada,
	output [31:0] salida

);
	assign salida = (entrada[15] == 1'b1 ? {16'b1111111111111111, entrada} : {16'b0, entrada});

endmodule 