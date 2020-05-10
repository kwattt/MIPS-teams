module buffer1(
 	input clk,
	input[31:0] entrada,

	output reg[31:26]op,
	output reg[25:21]rs,
	output reg[20:16]rt,
	output reg[15:11]rd,
	output reg[10:6]sh,
	output reg[5:0]func

);

always@(posedge clk)
begin
	op <= entrada;
	rs <= entrada;
	rt <= entrada;
	rd <= entrada;
	sh <= entrada;
	func <= entrada;
	
	end

endmodule 