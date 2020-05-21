module Mux3(
	input [4:0]entrada1,
	input [4:0]entrada0,
	input RegDst,
	output [4:0]salida
	
);
assign
	salida = (RegDst)? entrada1 : entrada0;

endmodule 