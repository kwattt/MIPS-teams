module pc(
    input clk,
    input [31:0]entrada,
    output reg [31:0]salida
);

initial begin
    salida = 32'b0;
end

always@(posedge clk) begin
    if (entrada != 1'bx) salida <= entrada;
end

endmodule