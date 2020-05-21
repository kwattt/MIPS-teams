module branch(
	input Branch,
	input zflag,
	output salida	
);

assign 
	salida = zflag & Branch;

endmodule 