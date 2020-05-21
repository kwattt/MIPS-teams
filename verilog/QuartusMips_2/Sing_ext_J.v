module Sing_ext_J(
	input [25:0]entrada,
	output [31:0] salida

);
assign 
  salida = (6'b0+entrada);
 
endmodule 