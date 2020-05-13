module buffer1(
 	input clk,
	input[31:0] entrada,
	input [31:0] entr_pc,
	output reg [31:0]salida,
	output reg [31:0]sal_pc
);


always@(posedge clk)
begin
	salida <= entrada;	
	sal_pc <= entr_pc;
end

endmodule 