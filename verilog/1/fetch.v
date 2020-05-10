module fetch (
	
	input clk,
	output salida
	
);

wire[7:0]pc_istruc;
pc pc1
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
	.op(buffer1[31:26]), 
	.rs(buffer1[25:21]),
	.rt(buffer1[20:16]),
	.rd(buffer1[15:11]),
	.sh(),
	.func(buffer1[5:0])
);

wire[5:0]buffer2_ban;
wire[31:0]ban_alu;
wire[4:0]ban_buffer;
wire[31:0]data1_beffer2;
wire[31:0]data2_beffer2;
wire buf2_ban;
BancoRegistros Br(

	.Regwrite(buf2_ban),
	.ReadReg1(buffer1[25:21]),
	.ReadReg2(buffer1[20:16]),
	.WriteReg(ban_buffer),
	.WriteData(ban_alu), 
	
	.ReadData1(data1_beffer2), 
	.ReadData2(data2_beffer2)
);

wire[2:0]AluOP_buffer2;
wire RegDsr_buffer2;
UnidadControl control
(
	.Entrada(buffer1[31:26]),
	.RegDsr(RegDsr_buffer2),
	.AluOP(AluOP_buffer2)

);

wire[31:0]Data2;
wire[31:0]Data1;
wire[5:0]data_alucont;
wire[2:0]buffer2_aluco;
buffer2 bufferb
(
	.clk(clk),
	.AluOP(AluOP_buffer2),
	.data1(data1_beffer2),
	.data2(data2_beffer2),
	.en1(buffer1[15:11]),
	.en2(buffer1[5:0]),
	.RegDsr(RegDsr_buffer2),

	
	.salida_alu(buffer2_aluco),
	.salida_RegDsr(buffer2_ban),
	.data1_salida(Data1),
	.data2_salida(Data2),
	.salida1(ban_buffer),
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