
module pc(input halt, output logic [5:0] pc, input we, input [5:0] jpc, input clk, rst);
	always @(posedge clk or posedge rst)
		if(rst) pc <= 0;
		else if(!halt) begin
			if(we == 1'b1) pc <= jpc;
			else pc <= pc + 1;
		end
endmodule
