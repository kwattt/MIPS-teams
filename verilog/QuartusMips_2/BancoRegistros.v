module BancoRegistros (
	input [4:0]ReadReg1, 
	input [4:0]ReadReg2,
	input [4:0]WriteReg, 
	input [31:0]WriteData,
	input Regwrite,
	
	output [31:0]ReadData1, 
	output [31:0]ReadData2
);

reg [31:0]AlmacenReg[0:31];


initial
begin
	$readmemb("bancoreg.txt", AlmacenReg,0,31);
	#10;
end

assign ReadData1 = AlmacenReg[ReadReg1];
assign ReadData2 = AlmacenReg[ReadReg2];

always @*
begin
    if(Regwrite == 1'b1) AlmacenReg[WriteReg] <= WriteData;
end

endmodule 