module MemoriaDato (
	input [31:0]Address,
	input [31:0]WriteData,
	input MemRead,
	input MemWrite,
	
	output [31:0]MemRes
);

reg [7:0]mem[0:1024];

always @*
begin
	
	mem[WriteData] <= MemRes;
	mem[Address] <= MemRes;
	
end

endmodule  