
module instrucmemory(
	input [7:0]direccion,
	output reg [31:0]salida_datos

);

reg [7:0]mem[0:128];


initial
begin
	$readmemb("instrucciones.txt", mem,0,128);
	#10;
end

always @*
begin

	salida_datos <= {mem[direccion],mem[direccion+1],mem[direccion+2],mem[direccion+3]};
end

endmodule 