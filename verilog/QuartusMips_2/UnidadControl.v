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
	
	if(Entrada == 6'b000000) //R basic
	begin
		RegDst <= 1; // Guarda en reg
		AluOP <= 2;
	end
	
	else if(Entrada == 6'b001000) //I
	begin
		ALUsrc <= 1; 
		AluOP <= 1;
		Branch <= 1;
		MemRead <= 0;
		MemtoReg <= 0;
	end
	
	else if(Entrada == 6'b0010000) //ADDI
	begin	
		ALUsrc <= 1;
		RegWrite <= 1;
		AluOP <= 0;
		$display("ADDI");
	end

	else if(Entrada == 6'b110001) //LW
	begin
		RegDst <= 0;
		Jump <= 0;
		ALUsrc <= 1;
		MemtoReg <= 1;
		RegWrite <= 1;
		MemRead <= 1;
		MemWrite <= 0;
		Branch <= 0;
		AluOP <= 0;
		$display("LW");
	end

	else if (Entrada == 6'b101011) // SW
	begin
		RegDst <= 1'bX;
		Jump <= 0;
		ALUsrc <= 1;
		MemtoReg <= 1'bX;
		RegWrite <= 0;
		MemRead <= 0;
		MemRead <= 1;
		MemWrite <= 1;
		Branch <= 0;
		AluOP <= 0;
		$display("SW");
	end

	else if (Entrada == 6'b000100) // BEQ
	begin
		RegDst <= 1'bX;
		Jump <= 0;
		ALUsrc <= 1'b0;
		MemtoReg <= 1'bx;
		RegWrite <= 1'bx;
		MemRead <= 1'bx;
		MemWrite <= 1'bx;
		Branch <= 1'b1;
		AluOP <= 2'b01;
		$display("BEQ");
	end
	
	else if (Entrada == 6'b001010) // SLTI
	begin
		RegDst <= 1'bX;
		Jump <= 0;
		ALUsrc <= 1;
		MemtoReg <= 0;
		RegWrite <= 1;
		MemRead <= 1'bx;
		MemWrite <= 1'bx;
		Branch <= 1'b1;
		AluOP <= 2'b00;
		$display("SLTI");
	end

	else if (Entrada == 6'b000010) // J
	begin
		RegDst <= 1'bX;
		Jump <= 1;
		ALUsrc <= 1;
		MemtoReg <= 1;
		RegWrite <= 1;
		MemRead <= 1'bx;
		MemWrite <= 1'bx;
		Branch <= 1'b1;
		AluOP <= 1;
		$display("J");
	end
end

endmodule 
