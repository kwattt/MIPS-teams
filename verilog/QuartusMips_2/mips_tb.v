`timescale 1ns / 1ps
module mips_tb;

    reg clk = 0;

    mips mipsx(clk);
    always begin
        #10; 
        clk <= ~clk;
    end

    integer i,f;
    initial begin

        $dumpvars(0, mips_tb);

        #50000;

        $finish;
    end

endmodule