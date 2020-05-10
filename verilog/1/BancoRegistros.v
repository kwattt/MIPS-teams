module BancoRegistros (
	input [4:0]ReadReg1, 
	input [4:0]ReadReg2,
	input [4:0]WriteReg, 
	input [31:0]WriteData,
	input Regwrite,
	
	output reg [31:0]ReadData1, 
	output reg [31:0]ReadData2
);


reg [31:0]AlmacenReg[0:31];


`timescale 1ns/1ns

/*initial
begin
	$readmemb("C:\\Computacion\\almacenBr.txt", AlmacenReg,0,31);
	#10;
end*/

always @*
begin
	
	AlmacenReg[WriteData] <= WriteData;
	
	ReadData1 <= AlmacenReg[ReadReg1];
	ReadData2 <= AlmacenReg[ReadReg2];
	
end

endmodule 