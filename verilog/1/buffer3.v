module buffer3 (
	input clk,
	input zflag,
	input [31:0]entrada,
	input [4:0]rd,
	
	output reg[5:0]zflagSalida,
	output reg [31:0]salida,
	output reg[4:0]rdSalida
);

always @(posedge clk)
begin
	zflagSalida <= zflag;
	salida <= entrada;
	rdSalida <= rd;
end

endmodule
