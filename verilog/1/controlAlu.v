module controlAlu (
	input[5:0]entrada,
	input[2:0]Op,
	
	output reg[3:0]salida
);

always@(entrada, Op) begin
	if(Op==3'b010) //2 func based
	begin
		if(entrada[3:0] == 0) begin //sum
			salida=4'b0010;
		end

		else if(entrada[3:0] == 4'b0010) begin //resta
			salida = 4'b0110;
		end

		else if(entrada[3:0] == 4'b0100) begin //and
			salida = 4'b0000;       
		end
		
		else if(entrada[3:0] == 4'b0101) begin //or
			salida = 4'b0001;
		end
		
		else if(entrada[3:0] == 4'b1100) begin //lessThan
			salida = 4'b0111;
		end

		else if(entrada[3:0] == 4'b0010) begin // multiplication
			salida = 4'b1000;
		end

		else if(entrada[3:0] == 4'b1010) begin //division
			salida = 4'b1010;
		end

		else if(entrada[3:0] == 4'b0110) begin //xor
			salida = 4'b0101;
		end

		else if(entrada[3:0] == 4'b0111) begin //nor
			salida = 4'b1100;
		end

end

end

endmodule


