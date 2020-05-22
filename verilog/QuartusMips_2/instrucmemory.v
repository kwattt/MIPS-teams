
module instrucmemory(
	input [31:0]direccion,
	output reg [31:0]salida_datos

);

reg [7:0]mem[0:1023];

initial begin
	$readmemb("instrucciones.txt", mem);
end

always @*
begin

	salida_datos <= {mem[direccion],mem[direccion+1],mem[direccion+2],mem[direccion+3]};
end

endmodule 