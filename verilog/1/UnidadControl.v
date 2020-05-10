module UnidadControl (
input[5:0]Entrada,

	output reg RegDsr,
	output reg [2:0]AluOP

);

always@* begin

if(Entrada == 6'b000000) //R basic
	begin
		RegDsr <= 1; // Guarda en reg
		AluOP <= 2;

	end

end

endmodule 
