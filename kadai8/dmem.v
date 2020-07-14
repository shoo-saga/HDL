
module dmem(input [7:0] ad, input [15:0] wd, input we, output [15:0] rd, input clk);
	logic [15:0] dm [255:0];
	assign rd = dm[ad];
	always @(posedge clk) begin
		if(we) dm[ad] <= wd;
	end
endmodule
