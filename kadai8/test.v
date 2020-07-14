
module test;
	logic clk, rst;
	logic [15:0] wd;
	pu pu(we, wd, clk, rst);
	always #2 clk =~ clk;
initial begin
$dumpfile("pu.vcd");
$dumpvars(0, pu);
rst = 1;
clk = 0;
#0
rst = 0;
#2000
$finish;
end
endmodule
