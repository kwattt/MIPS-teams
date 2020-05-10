`timescale 1ns / 1ps
module mips_tb;

    reg clk = 0;
    wire salida;

    fetch mipsx(clk, salida);
    always begin
        #10; 
        clk <= ~clk;
    end

    integer i,f;
    initial begin

        $dumpvars(0, mips_tb);

        #5000;

        $finish;
    end

endmodule