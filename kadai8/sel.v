module sel(input [15:0] a, b, input s, output logic [15:0] o);
	always_comb
		if(s) o = b;
		else o = a;
endmodule
