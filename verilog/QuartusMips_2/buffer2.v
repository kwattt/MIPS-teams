module buffer2 (
	input clk,
	input [2:0]AluOP,
	input [31:0]data1,
	input [31:0]data2,
	input [15:11]en1,
	input [5:0]en2,
	input RegWrite,
	
	output reg[2:0]salida_alu,
	output reg salida_RegWrite,
	output reg[31:0]data1_salida,
	output reg[31:0]data2_salida,
	output reg[15:11]salida1,
	output reg[5:0]salida2
);

always @(posedge clk)
begin
	salida_alu <= AluOP;
	salida_RegWrite <= RegWrite;
	data1_salida <= data1;
	data2_salida <= data2;
	salida1 <= en1;
	salida2 <= en2;
end

endmodule
