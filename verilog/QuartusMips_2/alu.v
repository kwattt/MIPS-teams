module alu (
	input [31:0]Data1,
	input [31:0]Data2,
	input [3:0]selector,
	output reg [31:0]salida,
	output zflag

);

assign zflag = (salida == 0);
reg [31:0]tmp;

always @*
begin
    case (selector)
        4'b0000: salida <= Data1 & Data2; //and
        4'b0001: salida <= Data1 | Data2; //or
        4'b0010: salida <= Data1 + Data2; //suma
        4'b0110: salida <= Data1 - Data2; //resta
		4'b0111: begin
            if (Data1[31] ^ Data2[31]) begin
                salida <= Data1[31];
                $display("me");
            end 
            else begin
                tmp = Data1-Data2;
                $display("me2");
                salida <= {31'b0, tmp[31]};
            end
        end      
        4'b0101: salida <= Data1 ^ Data2; // XOR 
        4'b1100: salida <= ~(Data1 | Data2); // nor
        4'b1000: salida <= Data1 * Data2; // MUL
        4'b1010: salida <= Data1 / Data2; // div
        default: salida <= Data2;
    endcase
end

endmodule
