module alu (
	input [31:0]Data1,
	input [31:0]Data2,
	input [3:0]selector,
	output reg [31:0]salida

);
assign op1 = Data1;
assign op2 = Data2;
always @*
begin
	case(selector)
		4'b1001 : salida = op1 + op2;
		4'b1000 : salida = op1 - op2;
		4'b0100 : salida = op1 * op2;
		4'b0001 : salida = op1 / op2;
		4'b0101 : salida = op1 & op2;
		4'b0110 : salida = op1 | op2;
		4'b0010 : salida = !(op1 | op2);
		4'b0111 : salida = op1 < op2 ? 1:0; 
		
	endcase
end

endmodule
