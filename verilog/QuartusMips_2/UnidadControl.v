module UnidadControl (
	input[5:0]Entrada,

	output reg RegDst,
	output reg ALUsrc,
	output reg [2:0]AluOP,
	output reg Branch,
	output reg MemRead,
	output reg MemtoReg,
	output reg RegWrite

);

always@* begin
	if(Entrada == 6'b000000) //R basic
	begin
		RegDst <= 1; // Guarda en reg
		AluOP <= 2;
	end
end

endmodule 
