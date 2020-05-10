module mips (
	
	input clk,
	output salida
	
);

wire[31:0]pc_istruc;

pc pcounter
(
	.clk(clk),
	.salida(pc_istruc)
);

wire[31:0]instr_buffer;

instrucmemory instrucmemory1
(
	.direccion(pc_istruc),
	.salida_datos(instr_buffer)
);



wire[31:0]buffer1;

buffer1 bufferA
(
 	.clk(clk),
	.entrada(instr_buffer),
    .salida(buffer1)
);

wire[31:26]opcode;
wire[25:21]read1;
wire[20:16]read2;
wire[15:11]rd;
wire[5:0]func;
wire [15:11]_writereg;

assign opcode = buffer1[31:26];
assign read1 = buffer1[25:21];
assign read2 = buffer1[20:16];
assign _writereg = buffer1[15:11];
assign func = buffer1[5:0];

wire buffer2_ban;
wire[31:0]ban_alu;
wire[4:0]ban_buffer;

wire[31:0]data1_beffer2;
wire[31:0]data2_beffer2;


wire [15:11]writereg;
BancoRegistros Br(

	.Regwrite(buffer2_ban),
	.ReadReg1(read1),
	.ReadReg2(read2),
	.WriteReg(writereg),
	.WriteData(ban_alu), 
	
	.ReadData1(data1_beffer2), 
	.ReadData2(data2_beffer2)
);

wire[2:0]AluOP_buffer2;
wire RegWrite_buffer2;

UnidadControl control
(
	.Entrada(opcode),
	.RegDst(RegWrite_buffer2),
	.AluOP(AluOP_buffer2)
);

wire[31:0]Data2;
wire[31:0]Data1;
wire[5:0]data_alucont;

wire[2:0]buffer2_aluco; // ALUOP 



buffer2 bufferb
(
	.clk(clk),

	.AluOP(AluOP_buffer2),

	.data1(data1_beffer2),
	.data2(data2_beffer2),

	.en1(_writereg),
	.en2(func),
	.RegWrite(RegWrite_buffer2),

	.salida_alu(buffer2_aluco),
	.salida_RegWrite(buffer2_ban),

	.data1_salida(Data1),
	.data2_salida(Data2),

	.salida1(writereg),
	.salida2(data_alucont)
);

wire[3:0]coalu_alu;
controlAlu controlalu1
(
	.entrada(data_alucont),
	.Op(buffer2_aluco),
	.salida(coalu_alu)
);

alu alu1
(
	.Data1(Data1),
	.Data2(Data2),
	.selector(coalu_alu),
	.salida(ban_alu)

);

assign salida = ban_alu;
 
endmodule 