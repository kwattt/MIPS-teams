module addpc(
    input clk,
    input [31:0]in,
    input [31:0]in2,
    output reg[31:0]out
);

always@(posedge clk) begin
    out <= in + in2;    
end


endmodule