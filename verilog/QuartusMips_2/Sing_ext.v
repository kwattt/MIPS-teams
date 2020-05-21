module Sing_ext(
	input [15:0]entrada,
	output [31:0] salida

);
assign 
  salida = (16'b0+entrada);
 
endmodule 