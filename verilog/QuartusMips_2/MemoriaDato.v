module MemoriaDato(
    input clk,

    input [31:0]Address,
    input [31:0]WriteData,
    input MemWrite,
    input MemRead,

    output reg[31:0]MemRes
    
);

reg [31:0]mem[31:0];

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) begin
    mem[i] = i;
    end
end

always@(posedge clk) begin
    if(MemWrite == 1) mem[Address] <= WriteData;
    if(MemRead == 1) MemRes <= mem[Address];
end

endmodule