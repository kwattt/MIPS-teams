module buffer1(
 	input clk,
	input[31:0] entrada,
	output reg [31:0]salida
);

always@(posedge clk)
begin
	salida <= entrada;	
end

endmodule 