transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/BancoRegistros.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/buffer1.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/buffer2.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/controlAlu.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/fetch.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/pc.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/UnidadControl.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/instrucmemory.v}

