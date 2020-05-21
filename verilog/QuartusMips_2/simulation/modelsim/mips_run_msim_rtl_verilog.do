transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/QuartusMips_2 {C:/Users/danao/Desktop/PROYECTO/MIPS-teams/verilog/QuartusMips_2/Mux2.v}

