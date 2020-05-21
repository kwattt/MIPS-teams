module UnidadControl (
	input[5:0]Entrada,

	output reg RegDst,
	output reg ALUsrc,
	output reg [2:0]AluOP,
	output reg Branch,
	output reg MemWrite,
	output reg MemRead,
	output reg Jump,
	output reg MemtoReg,
	output reg RegWrite

);

always@* 

begin

    RegDst <= 0; // MPX (0 <= 20-16, 1=15-11) < 
    Jump <= 0; // no salto 
    ALUsrc <= 0; // usa reg 0 o extended/imm 1
    MemtoReg <= 0; // de mem a reg
    RegWrite <= 0; // guardar en reg
    MemRead <= 0; // leer mem 
    MemWrite <= 0; // guardar mem
    Branch <= 0; // no branch
    AluOP <= 0; // ALU funcbased
    RegDst <= 0; // guarda en reg

	if(Entrada == 6'b000000) //R basic
	begin
		RegWrite <= 1;
		RegDst <= 1; // Guarda en reg
		AluOP <= 2;
	end
	
	else if(Entrada == 6'b001000) //ADDI
	begin	
		ALUsrc <= 1;
		RegWrite <= 1;
		$display("ADDI");
	end

	else if(Entrada == 6'b110001) //LW
	begin
        ALUsrc <= 1;
        MemtoReg <= 1;
        RegWrite <= 1;
        MemRead <= 1;
		$display("LW");
	end

	else if (Entrada == 6'b101011) // SW
	begin
        ALUsrc <= 1;
        MemWrite <= 1;
		$display("SW");
	end

	else if (Entrada == 6'b000100) // BEQ
	begin
		Branch <= 1'b1;
		AluOP <= 2'b01;
		$display("BEQ");
	end
	
	else if (Entrada == 6'b001010) // SLTI
	begin
        ALUsrc <= 1;
        RegWrite <= 1;
        AluOP <= 5;
        $display("SLTI");
	end

	else if (Entrada == 6'b000010) // J
	begin
		Jump <= 1;
		$display("J");
	end


    else if(Entrada == 6'b001100) // ANDI 
    begin
        ALUsrc <= 1;
        RegWrite <= 1;
        AluOP <= 3;
        $display("ANDI");
    end

    else if(Entrada == 6'b001101) // ORI 
    begin
        ALUsrc <= 1;
        RegWrite <= 1;
        AluOP <= 4;
        $display("ORI");
    end

end

endmodule 
