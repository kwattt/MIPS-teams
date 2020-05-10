module pc (
	input clk,
	
	output reg [31:0]salida
);


initial
begin
	salida <= -4;
end


always@(posedge clk)
begin
	salida <= salida+32'd4;
end


endmodule
