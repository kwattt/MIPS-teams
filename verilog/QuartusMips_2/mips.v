module mips (
	
	input clk
	
);

wire[31:0] mux1_MuxJump;
wire[31:0] pc_mux1;
wire[31:0] pc_buffer1;//------> que pedo?
wire[31:0]resBranch;
wire branch_mux1;


//////////////////////////////////
Mux1 Muxa(
	.ResBranch1(resBranch),
	.ResPc0(pc_mux1),
	.PcSrc(branch_mux1),
	
	.BResult(mux1_MuxJump)
	
);

wire[31:0]buffer3_MuxJumpV;
wire buffer3_MuxJump;
wire[31:0]MuxJump_Pc;
//////////////////////////////////
Mux_J muxJ(
	.JumpV1(buffer3_MuxJumpV),
	.BResult0(mux1_MuxJump),
	.Jump(buffer3_MuxJump),

	.Pc(MuxJump_Pc)
	
);
///////////////////////////////////
wire[31:0]pc_istruc;

pc pcounter
(
	.clk(clk),
	.entrada(MuxJump_Pc),
	
	.salida(pc_istruc)
);
//////////////////////////////////

assign pc_mux1 = pc_istruc ;
assign pc_buffer1 = pc_istruc ; 

wire[31:0]instr_buffer;

instrucmemory instrucmemory1
(
	.direccion(pc_istruc),
	
	.salida_datos(instr_buffer)
);
//////////////////////////////////

wire[31:0]bufer1;
wire[32:0]pc_buffer2;
buffer1 bufferA
(
 	.clk(clk),
	.entr_pc(pc_buffer1),
	.entrada(instr_buffer),
	
   .salida(bufer1),
	.sal_pc(pc_buffer2)
);

//////////////////////////////////

wire[31:26]opcode;
wire[25:0]tipoJ;
wire[25:21]read1;
wire[20:16]read2;
wire[15:0] sing;
wire[20:16]rd;
wire[15:11]_writereg;

assign opcode = bufer1[31:26];
assign tipoJ = buffer1[25:0];
assign read1 = bufer1[25:21];
assign read2 = bufer1[20:16];
assign sing = bufer1[15:0];
assign rd= bufer1[15:11];
//assign func = bufer1[5:0];
assign _writereg = bufer1[15:11];


wire[4:0] buffer4_ban;
wire[31:0]data1_beffer2;
wire[31:0]data2_beffer2;
wire[31:0]mux4_banco; 
wire[4:0]buffer4_bancoWR;

BancoRegistros Br(

	.Regwrite(buffer4_ban),
	.ReadReg1(read1),
	.ReadReg2(read2),
	.WriteReg(buffer4_bancoWR),
	.WriteData(mux4_banco), 
	
	.ReadData1(data1_beffer2), 
	.ReadData2(data2_beffer2)
);

//////////////////////////////////

wire RegWrite_buffer2;
wire MemtoReg_buffer2;
wire Jump_buffer2;
wire MemWrite_buffer2;
wire MemRead_buffer2;
wire Branch_buffer2;
wire[2:0]AluOP_buffer2;
wire ALUsrc_buffer2;
wire RegDst_buffer2;

UnidadControl control
(
	.Entrada(opcode),

	.RegDst(RegDst_buffer2),
	.ALUsrc(ALUsrc_buffer2),
	.AluOP(AluOP_buffer2),
	.Branch(Branch_buffer2),
	.MemRead(MemRead_buffer2),
	.MemWrite(MemWrite_buffer2),
	.Jump(Jump_buffer2),
	.MemtoReg(MemtoReg_buffer2),
	.RegWrite(RegWrite_buffer2)
);
//////////////////////////////////
wire[25:0]ShiftJ_SingJ;

Shift_left_J Shift2(
	.entrada(tipoJ),
	.salida(ShiftJ_SingJ),

);

/////////////////////////////////
wire[31:0]SingJ_buffer2;

Sing_ext_J Sing2(
	.entrada(ShiftJ_SingJ),
	.salida(SingJ_buffer2)

);

////////////////////////////////
wire[31:0]sing_buffer2;

Sing_ext sing_ext1(
	.entrada(sing),
	
	.salida(sing_buffer2)

);

//////////////////////////////////


wire[5:0]data_alucont; //<------ No si halla falla en este cable.
wire[31:0]buf2_shift;
wire[2:0]buffer2_aluco;  // ALUOP 
wire RWbuffer2_buffer3;    //RegWrite 
wire MemReg_Buffer2_buffer3;
wire MW_Buf2_buf3;				//memWrite
wire MR_buf2_buf3;			//MemtoReg
wire Br_buf2_buf3;		   //branch
wire buffer2_mux2;			//ALUSrc
wire buf2_mux3;		   //RegDst
wire [31:0]buffer2_adder;
wire [31:0]buffer2_Alu;
wire [31:0]Data2_buffer2_mux2;
wire [31:0]sing_buf2_mux2;//
wire [4:0]buffer2_mux3;
wire [4:0]sal2_mux;
wire Jump_buffer3;
wire [31:0]JumpV_buffer3;

assign buf2_shift = sing_buf2_mux2;
assign data_alucont = sing_buf2_mux2;

buffer2 bufferb
( 	.clk(clk),
	.en1(rd),
	.en2(_writereg),
	.sing_ex(sing_buffer2),
	.data1(data1_beffer2),
	.data2(data2_beffer2),
	.SingJump(SingJ_buffer2),
	.add_pc(pc_buffer2),
	.RegDst(RegDst_buffer2),
	.ALUSrc(ALUsrc_buffer2),
	.AluOP(AluOP_buffer2),
	.Branch(Branch_buffer2),
	.MemRead(MemRead_buffer2),
	.MemWrite(MemWrite_buffer2),
	.Jump(Jump_buffer2),
	.MemtoReg(MemtoReg_buffer2),
	.RegWrite(RegWrite_buffer2),

	.sal_RegWrite(RWbuffer2_buffer3),
	.sal_MemtoReg(MemReg_Buffer2_buffer4),
	.sal_MemWrite(MW_Buf2_buf4),
	.sal_Jump(Jump_buffer3),
	.sal_MemRead(MR_buf2_buf4),
	.sal_Branch(Br_buf2_buf3),
	.sal_AluOP(buffer2_aluco),
	.sal_ALUSrc(buffer2_mux2),
	.sal_RegDst(buf2_mux3),
	.sal_addPc(buffer2_adder),
	.sal_SingJump(JumpV_buffer3),
	.data1_salida(buffer2_Alu),
	.data2_salida(Data2_buffer2_mux2),
	.sal_singEx(sing_buf2_mux2),
	.salida1(buffer2_mux3),
	.salida2(buf2_mux3)
);
//////////////////////////////////
wire [31:0] shift_adder;

Shift_left(
	.entrada(buf2_shift),
	.salida(shift_adder)

);
//////////////////////////////////

wire [31:0]mux2_alu;
Mux2 Muxb (
	.sing_ext1(sing_buf2_mux2),
	.data0(buffer2_mux2),
	.aluSRC(Data_buffer2_mux2),
	
	.salida(mux2_alu)

);
//////////////////////////////////

wire [4:0] mux3_buf3;

Mux3 Muxc(
	.entrada1(buffer2_mux3),
	.entrada0(sal2_mux),
	.RegDst(buf2_mux3),
	.salida(mux3_buf3)
	
);

////////////////////////////////////
wire[3:0]coalu_alu;
controlAlu controlalu1
(
	.entrada(data_alucont),
	.Op(buffer2_aluco),
	
	.salida(coalu_alu)
);
//////////////////////////////////

wire zflag_buf3;
wire[31:0]AluRes_Buffer3;
alu alu1
(
	.Data1(buffer2_Alu),
	.Data2(mux2_alu),
	.selector(coalu_alu),

	.salida(AluRes_Buffer3),
	.zflag(zflag_buf3)

);


//////////////////////////////////

wire [31:0] BranchRes;
Adder(
	.entrPc(buffer2_adder),
	.entrShift(shift_adder),
	.ResBranch( BranchRes)
	
);
//////////////////////////////////

assign AluRes_buffer4 = AluRes_Adrees;
assign data2_Buffer3 = Data2_buffer2_mux2;
wire RW_buffer3_buffer4;
wire MemReg_buffer3_buffer4;
wire MemWrite_Memory;
wire MemRead_memory;
wire Branch_BranchADD;
wire zflag_Branch;
wire [31:0]AluRes_Adrees;
wire [31:0]Data2_Memory;
wire [4:0]writeReg_buffer4;

buffer3 bufferc(

	.clk(clk),
	.RegWrite(RWbuffer2_buffer3),
	.MemtoReg(MemReg_Buffer2_buffer3),
	.MemWrite(MW_Buf2_buf3),
	.Jump(Jump_buffer3),
	.MemRead(MR_buf2_buf3),
	.Branch(Br_buf2_buf3),
	.JumpV(JumpV_buffer3),
	.OutBranch(BranchRes),
	.zflag(zflag_buf3),
	.AluRes(AluRes_Buffer3),
	.Data2(data2_Buffer3),
	.writeReg(mux3_buf3),
	
	.sal_RegWrite(RW_buffer3_buffer4),
	.sal_MemtoReg(MemReg_buffer3_buffer4),
	.sal_MemWrite(MemWrite_Memory),
	.sal_Jump(buffer3_MuxJump),
	.sal_MemRead(MemRead_memory),
	.sal_Branch(Branch_BranchADD),
	.sal_JumpV(buffer3_MuxJumpV),
	.sal_OutBranch(resBranch),
	.sal_zflag(zflag_Branch),
	.sal_AluRes(AluRes_Adrees),
	.sal_Data2(Data2_Memory),
	.sal_writeReg(writeReg_buffer4)
);

//////////////////////////////////

branch branch1(
	.Branch(Branch_BranchADD),
	.zflag(zflag_Branch),
	
	.salida(branch_mux1)	
);

//////////////////////////////////
 
wire [31:0] MemRes_buffer4;
MemoriaDato MemDato (
	.Address(AluRes_Adrees),
	.WriteData(Data2_Memory),
	.MemRead(MemRead_memory),
	.MemWrite(MemWrite_Memory),
	
	.MemRes(MemRes_buffer4)

); 

//////////////////////////////////

wire memReg_Mux4;
wire [31:0]MemRes_Mux4;
wire [31:0]AluRes_Mux4;

buffer4 bufferd (
	.clk(clk),
	.RegWrite(RW_buffer3_buffer4),
	.MemToReg(MemReg_buffer3_buffer4),
	.MemRes(MemRes_buffer4),
	.AluRes(AluRes_buffer4),
	.WriteRegister(writeReg_buffer4),

	.sal_RegWrite(buffer4_ban),
	.sal_MemToReg(memReg_Mux4),
	.sal_MemRes(MemRes_Mux4),
	.sal_AluRes(AluRes_Mux4),
	.sal_WriteReg(buffer4_bancoWR)

);

//////////////////////////////////

Mux4  Mux_4(
	.AluRes0(AluRes_Mux4),
	.MemRes1(MemRes_Mux4),
	.MemtoReg(memReg_Mux4),
	
	.WriteDat(mux4_banco)
);
	

endmodule 
